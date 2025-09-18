# Nomad Cluster Deployment with Terraform

## Overview

This project demonstrates the deployment of a secure, scalable, and resilient HashiCorp Nomad cluster on AWS using Infrastructure as Code (Terraform). This is my implementation for the MLOps Engineer test task, showcasing distributed systems provisioning, secure networking, and infrastructure best practices.

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

## Features

### Core Requirements ✅
- [x] **Infrastructure as Code**: Complete Terraform configuration
- [x] **Cluster Topology**: 1 server + 2 clients (easily scalable)
- [x] **Secure UI Access**: Nomad UI with configurable access controls
- [x] **Workload Deployment**: Hello-world web application

### Bonus Features ✅
- [x] **CI/CD Automation**: GitHub Actions pipeline
- [x] **Security Best Practices**: VPC, security groups, IAM roles
- [x] **Observability**: Health checks, logs, and monitoring ready

## Quick Start

### Prerequisites

1. **AWS Account** with appropriate permissions
2. **AWS CLI** configured with credentials
3. **Terraform** (>= 1.0) installed
4. **SSH key pair** for instance access

### Option 1: Automated Deployment (Recommended)

```bash
# Clone the repository
git clone https://github.com/KoushalShrma/NomadTerraformDeployment.git
cd NomadTerraformDeployment

# Run the automated deployment script
./scripts/deploy.sh deploy
```

The script will:
- Check prerequisites
- Generate SSH keys
- Create terraform.tfvars
- Deploy infrastructure
- Wait for cluster readiness
- Deploy the hello-world application
- Display connection information

### Option 2: Manual Deployment

```bash
# 1. Generate SSH key
ssh-keygen -t rsa -b 4096 -f ~/.ssh/nomad-cluster-key -N ""

# 2. Configure Terraform variables
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your settings

# 3. Deploy infrastructure
terraform init
terraform plan
terraform apply

# 4. Deploy sample application
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

## Accessing the Cluster

### Nomad UI

After deployment, access the Nomad UI at:
```
http://<server-public-ip>:4646
```

### SSH Access

Connect to instances:
```bash
# Server
ssh -i ~/.ssh/nomad-cluster-key ubuntu@<server-ip>

# Clients
ssh -i ~/.ssh/nomad-cluster-key ubuntu@<client-ip>
```

### Application

The hello-world application will be available on the client nodes. Check the Nomad UI for the allocated ports.

## Sample Application

The included hello-world application demonstrates:

- **Containerized deployment** using Docker
- **Service registration** with Consul
- **Health checks** for reliability
- **Multiple instances** for high availability
- **Custom HTML** showing deployment details

### Deploying Custom Applications

1. Create a Nomad job file (`.nomad`)
2. Submit using: `nomad job run your-app.nomad`
3. Monitor via: `nomad job status your-app`

Example job structure:
```hcl
job "my-app" {
  datacenters = ["dev"]
  
  group "web" {
    count = 2
    
    task "app" {
      driver = "docker"
      config {
        image = "my-app:latest"
        ports = ["http"]
      }
    }
  }
}
```

## CI/CD Pipeline

The project includes a GitHub Actions workflow (`.github/workflows/deploy.yml`) that:

1. **Validates** Terraform code on PRs
2. **Plans** deployments for review
3. **Applies** changes on main branch
4. **Deploys** sample applications
5. **Destroys** infrastructure when needed

### Required Secrets

Configure these in your GitHub repository settings:

- `AWS_ACCESS_KEY_ID`: AWS access key
- `AWS_SECRET_ACCESS_KEY`: AWS secret key

### Manual Workflow Triggers

You can manually trigger deployments:

1. Go to Actions tab in GitHub
2. Select "Deploy Nomad Cluster"
3. Choose action: `plan`, `apply`, or `destroy`

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

## Troubleshooting

### Common Issues

1. **Cluster not starting**
   ```bash
   # Check services on server
   sudo systemctl status nomad consul
   sudo journalctl -u nomad -f
   ```

2. **Clients not joining**
   ```bash
   # Verify connectivity
   nomad node status
   consul members
   ```

3. **Application not deploying**
   ```bash
   # Check job status
   nomad job status hello-world
   nomad alloc logs <allocation-id>
   ```

### Useful Commands

```bash
# Cluster status
nomad server members
nomad node status

# Job management
nomad job status
nomad job stop hello-world

# Service discovery
consul catalog services
consul catalog nodes
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

## Project Structure

```
.
├── README.md                  # This file
├── terraform/                 # Infrastructure code
│   ├── main.tf               # Main Terraform configuration
│   ├── variables.tf          # Variable definitions
│   ├── outputs.tf            # Output values
│   ├── user_data_server.sh   # Server initialization script
│   └── user_data_client.sh   # Client initialization script
├── nomad-jobs/               # Nomad job definitions
│   └── hello-world.nomad     # Sample application
├── scripts/                  # Utility scripts
│   └── deploy.sh            # Automated deployment script
└── .github/workflows/        # CI/CD pipeline
    └── deploy.yml           # GitHub Actions workflow
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
**Project**: MLOps Engineer Test Task  
**Technology Stack**: Terraform, AWS, Nomad, Consul, Docker, GitHub Actions