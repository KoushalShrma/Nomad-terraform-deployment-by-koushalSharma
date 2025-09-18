#!/bin/bash

# Health check script for Nomad cluster
# Run this script to verify cluster status

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "🔍 Nomad Cluster Health Check"
echo "============================="

# Get server IP from Terraform output
cd "$PROJECT_ROOT/terraform"
if [ ! -f "terraform.tfstate" ]; then
    echo "❌ No Terraform state found. Please deploy the cluster first."
    exit 1
fi

server_ip=$(terraform output -raw nomad_server_public_ip 2>/dev/null || echo "")
if [ -z "$server_ip" ]; then
    echo "❌ Could not get server IP from Terraform output"
    exit 1
fi

echo "📍 Nomad Server IP: $server_ip"
echo ""

# Set Nomad address
export NOMAD_ADDR="http://$server_ip:4646"

# Check if Nomad server is reachable
echo "🌐 Checking Nomad server connectivity..."
if curl -s "$NOMAD_ADDR/v1/status/leader" &> /dev/null; then
    echo "✅ Nomad server is reachable"
else
    echo "❌ Nomad server is not reachable"
    echo "   Please check if the cluster is deployed and running"
    exit 1
fi

# Check if Nomad CLI is available
if command -v nomad &> /dev/null; then
    echo "✅ Nomad CLI is available"
    
    echo ""
    echo "📊 Cluster Status:"
    echo "=================="
    
    # Server members
    echo "🖥️  Server Members:"
    nomad server members 2>/dev/null || echo "   Could not get server members"
    
    echo ""
    echo "💻 Client Nodes:"
    nomad node status 2>/dev/null || echo "   Could not get node status"
    
    echo ""
    echo "🚀 Running Jobs:"
    nomad job status 2>/dev/null || echo "   No jobs running"
    
    # Check specific hello-world job
    echo ""
    echo "🌍 Hello-World Application:"
    if nomad job status hello-world &> /dev/null; then
        nomad job status hello-world | head -20
        echo ""
        echo "📱 Application Allocations:"
        nomad job allocs hello-world | head -10
    else
        echo "   Hello-world application not found"
        echo "   Deploy it with: nomad job run nomad-jobs/hello-world.nomad"
    fi
    
else
    echo "⚠️  Nomad CLI not found locally"
    echo "   You can still access the UI at: $NOMAD_ADDR"
fi

echo ""
echo "🌐 Access Information:"
echo "====================="
echo "Nomad UI: $NOMAD_ADDR"
echo "SSH to server: ssh -i ~/.ssh/nomad-cluster-key ubuntu@$server_ip"

# Check for client IPs
client_ips=$(terraform output -json nomad_client_public_ips 2>/dev/null | jq -r '.[]' 2>/dev/null || echo "")
if [ -n "$client_ips" ]; then
    echo ""
    echo "SSH to clients:"
    echo "$client_ips" | while read -r ip; do
        echo "  ssh -i ~/.ssh/nomad-cluster-key ubuntu@$ip"
    done
fi

echo ""
echo "📋 Quick Commands:"
echo "=================="
echo "Check job status:    nomad job status <job-name>"
echo "View logs:          nomad alloc logs <allocation-id>"
echo "Deploy application: nomad job run <job-file.nomad>"
echo "Scale application:  nomad job scale <job-name> <count>"

echo ""
echo "✅ Health check completed!"