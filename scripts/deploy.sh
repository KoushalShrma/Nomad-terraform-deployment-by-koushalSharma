#!/bin/bash

# Deployment helper script
# Author: Koushal Sharma (student)
# Purpose: small helper to run Terraform and submit the example Nomad job

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "Nomad cluster helper script"
echo "============================"

# Check prerequisites
check_prerequisites() {
    echo "Checking prerequisites..."

    if ! command -v terraform &> /dev/null; then
        echo "Terraform is not installed. Please install Terraform." >&2
        exit 1
    fi

    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install AWS CLI." >&2
        exit 1
    fi

    if ! aws sts get-caller-identity &> /dev/null; then
        echo "AWS credentials are not configured. Run 'aws configure'." >&2
        exit 1
    fi

    echo "Prerequisites OK"
}

# Generate SSH key if it doesn't exist
generate_ssh_key() {
    local key_path="$HOME/.ssh/nomad-cluster-key"

    if [ ! -f "$key_path" ]; then
        echo "Generating SSH key pair at $key_path"
    ssh-keygen -t rsa -b 4096 -f "$key_path" -N "" -C "nomad-cluster@demo"
        echo "SSH key generated"
    else
        echo "SSH key exists: $key_path"
    fi
}

# Create terraform.tfvars if it doesn't exist
create_tfvars() {
    local tfvars_path="$PROJECT_ROOT/terraform/terraform.tfvars"
    local ssh_key_path="$HOME/.ssh/nomad-cluster-key.pub"

    if [ ! -f "$tfvars_path" ]; then
        echo "Creating terraform.tfvars at $tfvars_path"
        cat > "$tfvars_path" << EOF
# Terraform variables for Nomad cluster deployment
# Edit values as needed for your environment

aws_region = "us-west-2"
environment = "dev"
cluster_name = "nomad-cluster"

# Instance configuration
server_instance_type = "t3.small"
client_instance_type = "t3.small"
client_count = 2

# SSH public key (paste or let the script fill from $ssh_key_path)
ssh_public_key = "$(cat $ssh_key_path)"

# Demo defaults - tighten these in production
allowed_ssh_cidr = ["0.0.0.0/0"]
allowed_ui_cidr = ["0.0.0.0/0"]
EOF
        echo "Created terraform.tfvars"
    else
        echo "terraform.tfvars already exists; skipping creation"
    fi
}

# Deploy infrastructure
deploy_infrastructure() {
    echo "Deploying infrastructure (terraform)..."
    cd "$PROJECT_ROOT/terraform"

    terraform init
    terraform plan
    terraform apply -auto-approve

    echo "Terraform apply finished"
}

# Wait for cluster to be ready
wait_for_cluster() {
    echo "Waiting for Nomad server to report a leader..."
    cd "$PROJECT_ROOT/terraform"
    server_ip=$(terraform output -raw nomad_server_public_ip)

    local max_attempts=30
    local attempt=1

    while [ $attempt -le $max_attempts ]; do
        echo "Checking Nomad at $server_ip (attempt $attempt/$max_attempts)"
        if curl -s "http://$server_ip:4646/v1/status/leader" | grep -q '"'; then
            echo "Nomad server is ready"
            return 0
        fi
        sleep 10
        attempt=$((attempt+1))
    done

    echo "Nomad server did not become ready in time" >&2
    exit 1
}

# Deploy sample application
deploy_application() {
    echo "Submitting hello-world job to Nomad"
    cd "$PROJECT_ROOT/terraform"
    server_ip=$(terraform output -raw nomad_server_public_ip)
    export NOMAD_ADDR="http://$server_ip:4646"

    nomad job run "$PROJECT_ROOT/nomad-jobs/hello-world.nomad"
    echo "Job submitted"
}

# Display connection information
show_connection_info() {
    echo "Deployment complete"
    cd "$PROJECT_ROOT/terraform"
    terraform output cluster_info || true

    echo "Nomad UI: $(terraform output -raw nomad_ui_url)"

    echo "SSH commands:"
    terraform output ssh_connection_commands || true

    server_ip=$(terraform output -raw nomad_server_public_ip)
    export NOMAD_ADDR="http://$server_ip:4646"
    nomad job status hello-world || echo "hello-world job may still be starting"
}

# Main deployment flow
main() {
    case "${1:-deploy}" in
        deploy)
            check_prerequisites
            generate_ssh_key
            create_tfvars
            deploy_infrastructure
            wait_for_cluster
            deploy_application
            show_connection_info
            ;;
        destroy)
            echo "Destroying infrastructure"
            cd "$PROJECT_ROOT/terraform"
            terraform destroy -auto-approve
            ;;
        status)
            show_connection_info
            ;;
        *)
            echo "Usage: $0 [deploy|destroy|status]"
            ;;
    esac
}

main "$@"