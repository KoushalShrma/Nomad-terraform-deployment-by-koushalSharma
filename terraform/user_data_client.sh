#!/bin/bash

# User data script for Nomad client
# This script sets up a Nomad client on Ubuntu

set -e

# Variables
CLUSTER_NAME="${cluster_name}"
ENVIRONMENT="${environment}"
SERVER_ADDRESS="${server_address}"
NOMAD_VERSION="1.6.2"
CONSUL_VERSION="1.16.1"

# Update system
apt-get update
apt-get install -y curl unzip jq

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ubuntu

# Install Consul (for service discovery)
cd /tmp
curl -O https://releases.hashicorp.com/consul/$${CONSUL_VERSION}/consul_$${CONSUL_VERSION}_linux_amd64.zip
unzip consul_$${CONSUL_VERSION}_linux_amd64.zip
mv consul /usr/local/bin/
chmod +x /usr/local/bin/consul

# Install Nomad
curl -O https://releases.hashicorp.com/nomad/$${NOMAD_VERSION}/nomad_$${NOMAD_VERSION}_linux_amd64.zip
unzip nomad_$${NOMAD_VERSION}_linux_amd64.zip
mv nomad /usr/local/bin/
chmod +x /usr/local/bin/nomad

# Create nomad user
useradd --system --home /etc/nomad.d --shell /bin/false nomad

# Create directories
mkdir -p /opt/nomad/data
mkdir -p /etc/nomad.d
mkdir -p /etc/consul.d
mkdir -p /opt/consul/data
chown -R nomad:nomad /opt/nomad
chown -R nomad:nomad /etc/nomad.d
chown -R nomad:nomad /opt/consul
chown -R nomad:nomad /etc/consul.d

# Get instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
LOCAL_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Create Consul configuration
cat > /etc/consul.d/consul.hcl << EOF
datacenter = "$${ENVIRONMENT}"
data_dir = "/opt/consul/data"
log_level = "INFO"
node_name = "$${CLUSTER_NAME}-client-$${INSTANCE_ID}"
bind_addr = "$${LOCAL_IPV4}"
client_addr = "127.0.0.1"
server = false
retry_join = ["$${SERVER_ADDRESS}"]
connect {
  enabled = true
}
EOF

# Create Nomad client configuration
cat > /etc/nomad.d/nomad.hcl << EOF
datacenter = "$${ENVIRONMENT}"
data_dir = "/opt/nomad/data"
log_level = "INFO"
bind_addr = "0.0.0.0"

server {
  enabled = false
}

client {
  enabled = true
  servers = ["$${SERVER_ADDRESS}:4647"]
  
  # Host volume for Docker socket
  host_volume "docker_sock" {
    path = "/var/run/docker.sock"
    read_only = false
  }
}

consul {
  address = "127.0.0.1:8500"
}

plugin "docker" {
  config {
    allow_privileged = true
    volumes {
      enabled = true
    }
  }
}
EOF

# Create systemd service for Consul
cat > /etc/systemd/system/consul.service << EOF
[Unit]
Description=Consul
Documentation=https://www.consul.io/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/consul.d/consul.hcl

[Service]
Type=exec
User=nomad
Group=nomad
ExecStart=/usr/local/bin/consul agent -config-dir=/etc/consul.d/
ExecReload=/bin/kill -HUP \$MAINPID
KillMode=process
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

# Create systemd service for Nomad
cat > /etc/systemd/system/nomad.service << EOF
[Unit]
Description=Nomad
Documentation=https://www.nomadproject.io/docs/
Requires=network-online.target
After=network-online.target
Wants=consul.service
After=consul.service

[Service]
Type=exec
User=nomad
Group=nomad
ExecStart=/usr/local/bin/nomad agent -config=/etc/nomad.d/nomad.hcl
ExecReload=/bin/kill -HUP \$MAINPID
KillMode=process
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF

# Enable and start services
systemctl daemon-reload
systemctl enable consul
systemctl enable nomad

# Wait a bit for server to be ready, then start services
sleep 60
systemctl start consul
sleep 10
systemctl start nomad

# Create a simple health check script
cat > /home/ubuntu/check_client.sh << 'EOF'
#!/bin/bash
echo "=== Consul Status ==="
consul members
echo ""
echo "=== Nomad Client Status ==="
nomad node status -self
EOF

chmod +x /home/ubuntu/check_client.sh
chown ubuntu:ubuntu /home/ubuntu/check_client.sh

# Log completion
echo "Nomad client setup completed at $(date)" >> /var/log/nomad-setup.log