echo "📍 Nomad Server IP: $server_ip"
#!/bin/bash

# Simple health-check helper
# Author: Koushal Sharma (student)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "Nomad cluster health check"

cd "$PROJECT_ROOT/terraform"
if [ ! -f "terraform.tfstate" ]; then
    echo "No Terraform state found. Deploy the cluster first." >&2
    exit 1
fi

server_ip=$(terraform output -raw nomad_server_public_ip 2>/dev/null || echo "")
if [ -z "$server_ip" ]; then
    echo "Could not read nomad_server_public_ip from terraform outputs" >&2
    exit 1
fi

echo "Nomad server IP: $server_ip"

export NOMAD_ADDR="http://$server_ip:4646"

if curl -s "$NOMAD_ADDR/v1/status/leader" > /dev/null; then
    echo "Nomad server reachable"
else
    echo "Nomad server is not reachable at $NOMAD_ADDR" >&2
    exit 1
fi

if command -v nomad &> /dev/null; then
    echo "Nomad CLI available — printing summary"
    echo "--- server members ---"
    nomad server members 2>/dev/null || echo "Could not list server members"
    echo "--- node status ---"
    nomad node status 2>/dev/null || echo "Could not list nodes"
    echo "--- running jobs ---"
    nomad job status 2>/dev/null || echo "No jobs or failed to query"

    if nomad job status hello-world &> /dev/null; then
        nomad job status hello-world | head -n 20
    else
        echo "hello-world job not found (you can run: nomad job run nomad-jobs/hello-world.nomad)"
    fi
else
    echo "Nomad CLI not installed locally — use the UI at $NOMAD_ADDR"
fi

echo "SSH to server: ssh -i ~/.ssh/nomad-cluster-key ubuntu@$server_ip"

# try to list client IPs if jq is available
if command -v jq &> /dev/null; then
    client_ips=$(terraform output -json nomad_client_public_ips 2>/dev/null | jq -r '.[]' 2>/dev/null || echo "")
    if [ -n "$client_ips" ]; then
        echo "Client SSH commands:"
        echo "$client_ips" | while read -r ip; do
            echo "  ssh -i ~/.ssh/nomad-cluster-key ubuntu@$ip"
        done
    fi
fi

echo "Health check finished"