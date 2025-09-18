# Testing and quick verification

This file lists the minimal credentials and verification steps I used when testing this project.

Prerequisites
- An AWS account and an IAM user with permissions to create EC2, VPC, and related resources
- AWS CLI configured locally (aws configure)

Quick verification (automated)

```bash
# from repo root - helper will create terraform/terraform.tfvars if missing
./scripts/deploy.sh deploy

# run a quick health check once Terraform finishes
./scripts/health-check.sh
```

Manual verification (short)

```bash
# generate an SSH key used by the helper scripts
ssh-keygen -t rsa -b 4096 -f ~/.ssh/nomad-cluster-key -N ""

cd terraform
cp terraform.tfvars.example terraform.tfvars
# paste your public key into `ssh_public_key` and update region if needed

terraform init
terraform apply

# when done, check cluster state (from a machine with nomad/consul CLIs):
export NOMAD_ADDR="http://$(terraform output -raw nomad_server_public_ip):4646"
nomad node status
nomad job status hello-world
```

Cost note
- The demo defaults use small instances. Destroy the infrastructure when you're done to avoid charges: `./scripts/deploy.sh destroy`.

Minimal checklist
- Terraform created instances
- Nomad server reachable on port 4646
- Clients registered and visible via `nomad node status`
- Hello-world job running (optional)

If something breaks, check systemd logs on the server:

```bash
ssh -i ~/.ssh/nomad-cluster-key ubuntu@<server-ip>
sudo journalctl -u nomad -f
sudo journalctl -u consul -f
```