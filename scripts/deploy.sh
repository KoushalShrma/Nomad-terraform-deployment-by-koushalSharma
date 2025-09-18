#!/bin/bash

# Deployment script for Nomad cluster
# This script helps deploy the infrastructure and applications

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "🚀 Nomad Cluster Deployment Script"
echo "=================================="

# Check prerequisites
check_prerequisites() {
    echo "Checking prerequisites..."
    
    # Check if terraform is installed
    if ! command -v terraform &> /dev/null; then
        echo "❌ Terraform is not installed. Please install Terraform first."
        exit 1
    fi
    
    # Check if AWS CLI is installed
    if ! command -v aws &> /dev/null; then
        echo "❌ AWS CLI is not installed. Please install AWS CLI first."
        exit 1
    fi
    
    # Check AWS credentials
    if ! aws sts get-caller-identity &> /dev/null; then
        echo "❌ AWS credentials are not configured. Please run 'aws configure'."
        exit 1
    fi
    
    echo "✅ Prerequisites check passed!"
}

# Generate SSH key if it doesn't exist
generate_ssh_key() {
    local key_path="$HOME/.ssh/nomad-cluster-key"
    
    if [ ! -f "$key_path" ]; then
        echo "Generating SSH key pair..."
        ssh-keygen -t rsa -b 4096 -f "$key_path" -N "" -C "nomad-cluster@student-project"
        echo "✅ SSH key generated: $key_path"
    else
        echo "✅ SSH key already exists: $key_path"
    fi
}

# Create terraform.tfvars if it doesn't exist
create_tfvars() {
    local tfvars_path="$PROJECT_ROOT/terraform/terraform.tfvars"
    local ssh_key_path="$HOME/.ssh/nomad-cluster-key.pub"
    
    if [ ! -f "$tfvars_path" ]; then
        echo "Creating terraform.tfvars..."
        cat > "$tfvars_path" << EOF
# Terraform variables for Nomad cluster deployment
# Modify these values according to your requirements

aws_region = "us-west-2"
environment = "dev"
cluster_name = "nomad-cluster"

# Instance configuration
server_instance_type = "t3.small"
client_instance_type = "t3.small"
client_count = 2

# SSH key (automatically generated)
ssh_public_key = "$(cat $ssh_key_path)"

# Security (modify these for production use)
allowed_ssh_cidr = ["0.0.0.0/0"]  # Allow SSH from anywhere (demo only!)
allowed_ui_cidr = ["0.0.0.0/0"]   # Allow UI access from anywhere (demo only!)
EOF
        echo "✅ Created terraform.tfvars"
    else
        echo "✅ terraform.tfvars already exists"
    fi
}

# Deploy infrastructure
deploy_infrastructure() {
    echo "Deploying infrastructure with Terraform..."
    
    cd "$PROJECT_ROOT/terraform"
    
    # Initialize Terraform
    echo "Initializing Terraform..."
    terraform init
    
    # Plan deployment
    echo "Planning deployment..."
    terraform plan
    
    # Apply deployment
    echo "Applying deployment..."
    terraform apply -auto-approve
    
    echo "✅ Infrastructure deployed successfully!"
}

# Wait for cluster to be ready
wait_for_cluster() {
    echo "Waiting for Nomad cluster to be ready..."
    
    cd "$PROJECT_ROOT/terraform"
    server_ip=$(terraform output -raw nomad_server_public_ip)
    
    echo "Checking Nomad server at $server_ip..."
    
    # Wait for Nomad to be ready (max 5 minutes)
    local max_attempts=30
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        echo "Attempt $attempt/$max_attempts: Checking Nomad server..."
        
        if curl -s "http://$server_ip:4646/v1/status/leader" &> /dev/null; then
            echo "✅ Nomad server is ready!"
            break
        fi
        
        if [ $attempt -eq $max_attempts ]; then
            echo "❌ Nomad server failed to become ready within 5 minutes"
            exit 1
        fi
        
        sleep 10
        ((attempt++))
    done
}

# Deploy sample application
deploy_application() {
    echo "Deploying hello-world application..."
    
    cd "$PROJECT_ROOT/terraform"
    server_ip=$(terraform output -raw nomad_server_public_ip)
    
    # Set Nomad address
    export NOMAD_ADDR="http://$server_ip:4646"
    
    # Submit the job
    nomad job run "$PROJECT_ROOT/nomad-jobs/hello-world.nomad"
    
    echo "✅ Hello-world application deployed!"
}

# Display connection information
show_connection_info() {
    echo ""
    echo "🎉 Deployment Complete!"
    echo "======================"
    
    cd "$PROJECT_ROOT/terraform"
    
    echo ""
    echo "📊 Cluster Information:"
    terraform output cluster_info
    
    echo ""
    echo "🌐 Access URLs:"
    echo "Nomad UI: $(terraform output -raw nomad_ui_url)"
    
    echo ""
    echo "🔑 SSH Commands:"
    terraform output ssh_connection_commands
    
    echo ""
    echo "🔍 Application Status:"
    server_ip=$(terraform output -raw nomad_server_public_ip)
    export NOMAD_ADDR="http://$server_ip:4646"
    nomad job status hello-world || echo "Job may still be starting..."
    
    echo ""
    echo "📱 Next Steps:"
    echo "1. Visit the Nomad UI: http://$server_ip:4646"
    echo "2. Check application status: nomad job status hello-world"
    echo "3. Access the hello-world app once it's running"
}

# Main deployment flow
main() {
    case "${1:-deploy}" in
        "deploy")
            check_prerequisites
            generate_ssh_key
            create_tfvars
            deploy_infrastructure
            wait_for_cluster
            deploy_application
            show_connection_info
            ;;
        "destroy")
            echo "🗑️ Destroying infrastructure..."
            cd "$PROJECT_ROOT/terraform"
            terraform destroy -auto-approve
            echo "✅ Infrastructure destroyed!"
            ;;
        "status")
            show_connection_info
            ;;
        *)
            echo "Usage: $0 [deploy|destroy|status]"
            echo "  deploy  - Deploy the complete Nomad cluster (default)"
            echo "  destroy - Destroy the infrastructure"
            echo "  status  - Show connection information"
            ;;
    esac
}

main "$@"