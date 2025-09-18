# Testing and Credentials Guide

## Required Credentials for Testing

To deploy and test this Nomad cluster deployment, you'll need the following credentials and access:

### AWS Credentials

1. **AWS Account**: Active AWS account with billing enabled
2. **IAM User**: Create an IAM user with the following permissions:
   - EC2 Full Access
   - VPC Full Access
   - IAM Limited Access (for creating instance profiles)

3. **AWS CLI Configuration**:
   ```bash
   aws configure
   ```
   You'll need:
   - AWS Access Key ID
   - AWS Secret Access Key
   - Default region (e.g., us-west-2)

### GitHub Secrets (for CI/CD)

If using the GitHub Actions pipeline, configure these secrets in your repository:

1. Go to repository Settings → Secrets and Variables → Actions
2. Add the following secrets:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key

## Testing Instructions

### 1. Local Testing

```bash
# Clone the repository
git clone https://github.com/KoushalShrma/NomadTerraformDeployment.git
cd NomadTerraformDeployment

# Verify prerequisites
./scripts/deploy.sh

# If prerequisites pass, deploy the cluster
./scripts/deploy.sh deploy
```

### 2. Manual Testing Steps

```bash
# 1. Generate SSH key
ssh-keygen -t rsa -b 4096 -f ~/.ssh/nomad-cluster-key -N ""

# 2. Configure variables
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your SSH public key

# 3. Deploy infrastructure
terraform init
terraform plan
terraform apply

# 4. Test cluster health
cd ..
./scripts/health-check.sh

# 5. Deploy sample application
export NOMAD_ADDR="http://$(cd terraform && terraform output -raw nomad_server_public_ip):4646"
nomad job run nomad-jobs/hello-world.nomad

# 6. Verify deployment
nomad job status hello-world
```

### 3. UI Testing

1. **Nomad UI**: Access at `http://<server-ip>:4646`
   - View cluster status
   - Check running jobs
   - Monitor allocations

2. **Hello World Application**: 
   - Check the Nomad UI for allocated ports
   - Access via `http://<client-ip>:<allocated-port>`

### 4. CI/CD Testing

1. **Fork this repository** to your GitHub account
2. **Configure AWS secrets** in repository settings
3. **Push changes** to main branch to trigger deployment
4. **Monitor GitHub Actions** for deployment status

## Expected Costs

### AWS Resources (Approximate)

- **3x t3.small instances**: ~$45/month
- **EBS storage**: ~$3/month
- **Data transfer**: ~$2/month
- **Total**: ~$50/month

### Cost Optimization

For testing and learning:
- Use `t3.micro` instances (free tier eligible)
- Destroy resources when not in use
- Use the destroy script: `./scripts/deploy.sh destroy`

## Verification Checklist

After deployment, verify these components:

### Infrastructure
- [ ] VPC and subnets created
- [ ] Security groups configured
- [ ] EC2 instances running
- [ ] SSH access working

### Nomad Cluster
- [ ] Nomad server accessible via UI
- [ ] All client nodes joined cluster
- [ ] Consul service discovery working
- [ ] Docker driver available on clients

### Sample Application
- [ ] Hello-world job deployed successfully
- [ ] Application accessible via web browser
- [ ] Health checks passing
- [ ] Service registered in Consul

### Security
- [ ] Security groups restrict access appropriately
- [ ] SSH keys working for instance access
- [ ] No hardcoded credentials in code

## Troubleshooting Common Issues

### 1. AWS Credentials
```bash
# Verify AWS access
aws sts get-caller-identity

# Check current region
aws configure list
```

### 2. Terraform Issues
```bash
# Check Terraform state
terraform show

# Re-initialize if needed
terraform init -reconfigure
```

### 3. Nomad Cluster Issues
```bash
# SSH to server and check logs
ssh -i ~/.ssh/nomad-cluster-key ubuntu@<server-ip>
sudo journalctl -u nomad -f

# Check service status
sudo systemctl status nomad consul
```

### 4. Application Deployment Issues
```bash
# Check job status
nomad job status hello-world

# View allocation logs
nomad alloc logs <allocation-id>

# Check Docker on client
ssh -i ~/.ssh/nomad-cluster-key ubuntu@<client-ip>
sudo docker ps
```

## Demo Script

For presenting this project:

```bash
# 1. Show the repository structure
tree -I '.git|.terraform'

# 2. Validate configuration
cd terraform && terraform validate

# 3. Deploy (if demo environment allows)
./scripts/deploy.sh deploy

# 4. Show cluster status
./scripts/health-check.sh

# 5. Access UI and show running workloads
# Open browser to Nomad UI

# 6. Clean up
./scripts/deploy.sh destroy
```

## Student Notes

This project demonstrates:

1. **Infrastructure as Code**: Complete Terraform configuration
2. **Distributed Systems**: Multi-node cluster setup
3. **Container Orchestration**: Docker workload management
4. **Service Discovery**: Consul integration
5. **Automation**: CI/CD pipeline with GitHub Actions
6. **Security**: VPC, security groups, IAM roles
7. **Observability**: Health checks and monitoring readiness

The implementation follows best practices while remaining accessible for learning and demonstration purposes.

## Support

If you encounter issues:

1. Check the troubleshooting section above
2. Review Terraform and Nomad logs
3. Verify AWS credentials and permissions
4. Ensure all prerequisites are installed
5. Check the GitHub Actions workflow logs for CI/CD issues

Remember to destroy resources after testing to avoid unnecessary costs!