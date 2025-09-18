#!/bin/bash

# User data script for Nomad server
# This script sets up a Nomad server on Ubuntu

set -e

# Variables
CLUSTER_NAME="${cluster_name}"
ENVIRONMENT="${environment}"
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
chown -R nomad:nomad /opt/nomad
chown -R nomad:nomad /etc/nomad.d

# Get instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
LOCAL_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Create Consul configuration
cat > /etc/consul.d/consul.hcl << EOF
datacenter = "$${ENVIRONMENT}"
data_dir = "/opt/consul/data"
log_level = "INFO"
node_name = "$${CLUSTER_NAME}-server"
bind_addr = "$${LOCAL_IPV4}"
client_addr = "0.0.0.0"
server = true
bootstrap_expect = 1
ui_config {
  enabled = true
}
retry_join = ["$${LOCAL_IPV4}"]
connect {
  enabled = true
}
EOF

# Create Nomad server configuration
cat > /etc/nomad.d/nomad.hcl << EOF
datacenter = "$${ENVIRONMENT}"
data_dir = "/opt/nomad/data"
log_level = "INFO"
bind_addr = "0.0.0.0"

server {
  enabled = true
  bootstrap_expect = 1
}

client {
  enabled = false
}

consul {
  address = "127.0.0.1:8500"
}

# Basic UI security - In production, use proper authentication
acl = {
  enabled = false
}

ui {
  enabled = true
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

# Set ownership for consul directories
mkdir -p /opt/consul/data
chown -R nomad:nomad /opt/consul
chown -R nomad:nomad /etc/consul.d

# Enable and start services
systemctl daemon-reload
systemctl enable consul
systemctl enable nomad
systemctl start consul
sleep 10
systemctl start nomad

# Wait for services to be ready
sleep 30

# Create a simple health check script
cat > /home/ubuntu/check_cluster.sh << 'EOF'
#!/bin/bash
echo "=== Consul Status ==="
consul members
echo ""
echo "=== Nomad Server Status ==="
nomad server members
echo ""
echo "=== Nomad Node Status ==="
nomad node status
EOF

chmod +x /home/ubuntu/check_cluster.sh
chown ubuntu:ubuntu /home/ubuntu/check_cluster.sh

# Log completion
echo "Nomad server setup completed at $(date)" >> /var/log/nomad-setup.log