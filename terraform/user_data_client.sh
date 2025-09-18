#!/bin/bash

# Cloud-init / user-data for Nomad client (minimal, demo use)

set -euo pipefail

CLUSTER_NAME="${cluster_name}"
ENVIRONMENT="${environment}"
SERVER_ADDRESS="${server_address}"
NOMAD_VERSION="1.6.2"
CONSUL_VERSION="1.16.1"

apt-get update
apt-get install -y curl unzip jq

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ubuntu || true

cd /tmp
curl -O https://releases.hashicorp.com/consul/$${CONSUL_VERSION}/consul_$${CONSUL_VERSION}_linux_amd64.zip
unzip consul_$${CONSUL_VERSION}_linux_amd64.zip
mv consul /usr/local/bin/
chmod +x /usr/local/bin/consul

curl -O https://releases.hashicorp.com/nomad/$${NOMAD_VERSION}/nomad_$${NOMAD_VERSION}_linux_amd64.zip
unzip nomad_$${NOMAD_VERSION}_linux_amd64.zip
mv nomad /usr/local/bin/
chmod +x /usr/local/bin/nomad

if ! id -u nomad >/dev/null 2>&1; then
  useradd --system --home /etc/nomad.d --shell /bin/false nomad
fi

mkdir -p /opt/nomad/data /etc/nomad.d /etc/consul.d /opt/consul/data
chown -R nomad:nomad /opt/nomad /etc/nomad.d /opt/consul /etc/consul.d

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
LOCAL_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

cat > /etc/consul.d/consul.hcl << EOF
datacenter = "$${ENVIRONMENT}"
data_dir = "/opt/consul/data"
log_level = "INFO"
node_name = "$${CLUSTER_NAME}-client-$${INSTANCE_ID}"
bind_addr = "$${LOCAL_IPV4}"
client_addr = "127.0.0.1"
server = false
retry_join = ["$${SERVER_ADDRESS}"]
connect { enabled = true }
EOF

cat > /etc/nomad.d/nomad.hcl << EOF
datacenter = "$${ENVIRONMENT}"
data_dir = "/opt/nomad/data"
log_level = "INFO"
bind_addr = "0.0.0.0"

server { enabled = false }
client {
  enabled = true
  servers = ["$${SERVER_ADDRESS}:4647"]
  host_volume "docker_sock" { path = "/var/run/docker.sock" read_only = false }
}

consul { address = "127.0.0.1:8500" }

plugin "docker" { config { allow_privileged = true volumes { enabled = true } } }
EOF

cat > /etc/systemd/system/consul.service << EOF
[Unit]
Description=Consul
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

cat > /etc/systemd/system/nomad.service << EOF
[Unit]
Description=Nomad
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

systemctl daemon-reload
systemctl enable consul
systemctl enable nomad

sleep 60
systemctl start consul || true
sleep 10
systemctl start nomad || true

cat > /home/ubuntu/check_client.sh << 'EOF'
#!/bin/bash
echo "Consul members:"
consul members || true
echo "Nomad client status (self):"
nomad node status -self || true
EOF

chmod +x /home/ubuntu/check_client.sh
chown ubuntu:ubuntu /home/ubuntu/check_client.sh

echo "Nomad client setup completed at $(date)" >> /var/log/nomad-setup.log