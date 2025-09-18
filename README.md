# Nomad Cluster Deployment with Terraform

## About this project

I built this repository as a student project to demonstrate provisioning a small HashiCorp Nomad cluster on AWS using Terraform. The goal was to show practical infrastructure-as-code, basic networking, and a simple application deployment with Nomad and Consul.

## Architecture

### Infrastructure Design

```
┌─────────────────────────────────────────────────────┐
│                     AWS VPC                        │
│  ┌─────────────────┐    ┌─────────────────────────┐ │
│  │   Subnet AZ-1   │    │      Subnet AZ-2        │ │
│  │                 │    │                         │ │
│  │ ┌─────────────┐ │    │ ┌─────────────────────┐ │ │
│  │ │   Nomad     │ │    │ │   Nomad Client      │ │ │
│  │ │   Server    │ │    │ │   Node 1            │ │ │
│  │ │             │ │    │ │                     │ │ │
│  │ │ + Consul    │ │    │ │ + Docker            │ │ │
│  │ │ + UI        │ │    │ │ + Consul Agent      │ │ │
│  │ └─────────────┘ │    │ └─────────────────────┘ │ │
│  └─────────────────┘    │                         │ │
│                         │ ┌─────────────────────┐ │ │
│                         │ │   Nomad Client      │ │ │
│                         │ │   Node 2            │ │ │
│                         │ │                     │ │ │
│                         │ │ + Docker            │ │ │
│                         │ │ + Consul Agent      │ │ │
│                         │ └─────────────────────┘ │ │
│                         └─────────────────────────┘ │
└─────────────────────────────────────────────────────┘
```

### Components

- **1 Nomad Server**: Manages the cluster state, scheduling, and provides the UI
- **2 Nomad Clients**: Execute workloads and run containerized applications
- **Consul**: Service discovery and health checking
- **Docker**: Container runtime for applications
- **VPC**: Isolated network environment with public subnets
- **Security Groups**: Firewall rules for secure communication

### What you'll find here

- Terraform code to create a small Nomad cluster (1 server, configurable number of clients)
- Example Nomad job (`nomad-jobs/hello-world.nomad`) that runs a simple nginx container
- Scripts to automate local deployment and basic health checks (`scripts/`)
- A GitHub Actions workflow that demonstrates how CI could validate/plan changes

## Quick Start

### Prerequisites

1. **AWS Account** with appropriate permissions
2. **AWS CLI** configured with credentials
3. **Terraform** (>= 1.0) installed
4. **SSH key pair** for instance access

### Quick start (automated)

Clone the repo and run the helper script to deploy a demo cluster. The script runs Terraform and deploys the example job.

```bash
git clone https://github.com/KoushalShrma/NomadTerraformDeployment.git
cd NomadTerraformDeployment
./scripts/deploy.sh deploy
```

The script will check prerequisites, create `terraform/terraform.tfvars` (if missing), run Terraform, wait for the server, and submit the example job.

### Manual deployment

If you prefer to run Terraform manually:

```bash
# generate an SSH key (used by the helper scripts)
ssh-keygen -t rsa -b 4096 -f ~/.ssh/nomad-cluster-key -N ""

cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars and paste your public key into `ssh_public_key`

terraform init
terraform apply

# When Terraform finishes, run the example job from the repo root:
export NOMAD_ADDR="http://$(terraform output -raw nomad_server_public_ip):4646"
nomad job run ../nomad-jobs/hello-world.nomad
```

## Configuration

### Terraform Variables

Create `terraform/terraform.tfvars`:

```hcl
aws_region = "us-west-2"
environment = "dev"
cluster_name = "my-nomad-cluster"

# Instance configuration
server_instance_type = "t3.small"
client_instance_type = "t3.small"
client_count = 2

# SSH key (paste your public key here)
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2E..."

# Security (restrict in production!)
allowed_ssh_cidr = ["YOUR_IP/32"]
allowed_ui_cidr = ["YOUR_IP/32"]
```

### Scaling

To add more client nodes:

```hcl
# In terraform.tfvars
client_count = 5  # Increase from 2 to 5
```

Then run:
```bash
terraform apply
```

## Access

Nomad UI: http://<server-public-ip>:4646

SSH (example):

```bash
# Server
ssh -i ~/.ssh/nomad-cluster-key ubuntu@<server-ip>

# Clients
ssh -i ~/.ssh/nomad-cluster-key ubuntu@<client-ip>
```

Check the Nomad UI for job status and allocated ports for the example app.

## Sample app

The example Nomad job runs a small nginx container and demonstrates how to register services with Consul and use health checks. To run your own, create a `.nomad` job and use `nomad job run`.

## CI/CD

There is a sample GitHub Actions workflow that shows how Terraform plan/apply could be run in CI. If you use it, add `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` to repository secrets.

## Security Considerations

### Current Implementation
- VPC with isolated networking
- Security groups with minimal required ports
- IAM roles with basic permissions
- SSH key-based authentication

### Production Recommendations
- Enable Nomad ACLs for authentication
- Use private subnets with NAT gateway
- Implement TLS encryption
- Restrict security group rules to specific IPs
- Use AWS Systems Manager for access
- Enable CloudTrail for auditing
- Implement backup strategies

## Monitoring and Observability

### Health Checks
- Consul health checks for services
- Nomad built-in health monitoring
- Application-level health endpoints

### Logs
- System logs: `/var/log/nomad-setup.log`
- Application logs: Available through Nomad UI
- Docker logs: `docker logs <container>`

### Metrics
Ready for integration with:
- Prometheus (metrics collection)
- Grafana (visualization)
- ELK Stack (log aggregation)

## Troubleshooting (short)

On the server, check Nomad and Consul systemd services and logs:

```bash
sudo systemctl status nomad consul
sudo journalctl -u nomad -f
```

Nomad/Consul queries (from a machine with the CLIs):

```bash
nomad node status
consul members
nomad job status hello-world
```

## Cost Optimization

The default configuration uses:
- 3x t3.small instances (~$45/month)
- Standard networking (minimal cost)
- EBS storage (minimal cost)

To reduce costs:
- Use t3.micro for development
- Stop instances when not in use
- Use spot instances for non-critical workloads

## Cleanup

### Destroy Infrastructure

```bash
# Using script
./scripts/deploy.sh destroy

# Or manually
cd terraform
terraform destroy
```

### Remove Local Files

```bash
# Remove SSH keys
rm ~/.ssh/nomad-cluster-key*

# Remove Terraform state (optional)
rm terraform/terraform.tfstate*
```

## Project structure

```
.
├── README.md
├── terraform/             # Terraform code and user-data scripts
├── nomad-jobs/            # Example job files
├── scripts/               # Helper scripts (deploy, health-check)
└── .github/workflows/     # CI examples
```

## Learning Resources

- [HashiCorp Nomad Documentation](https://developer.hashicorp.com/nomad/docs)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Consul Service Discovery](https://developer.hashicorp.com/consul/docs)

## Contributing

This is a student project for demonstration purposes. Feel free to fork and experiment!

## License

This project is for educational purposes. Use at your own risk.

---

**Author**: Koushal Sharma
**Project**: Student demo — Nomad on AWS
**Tech**: Terraform, AWS, Nomad, Consul, Docker