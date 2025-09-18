# Terraform outputs for easy access to cluster information

output "nomad_server_public_ip" {
  description = "Public IP address of the Nomad server"
  value       = aws_instance.nomad_server.public_ip
}

output "nomad_server_private_ip" {
  description = "Private IP address of the Nomad server"
  value       = aws_instance.nomad_server.private_ip
}

output "nomad_client_public_ips" {
  description = "Public IP addresses of Nomad clients"
  value       = aws_instance.nomad_client[*].public_ip
}

output "nomad_client_private_ips" {
  description = "Private IP addresses of Nomad clients"
  value       = aws_instance.nomad_client[*].private_ip
}

output "nomad_ui_url" {
  description = "URL to access Nomad UI"
  value       = "http://${aws_instance.nomad_server.public_ip}:4646"
}

output "ssh_connection_commands" {
  description = "SSH commands to connect to instances"
  value = {
    server = "ssh -i ~/.ssh/${var.cluster_name}-key ubuntu@${aws_instance.nomad_server.public_ip}"
    clients = [
      for i, ip in aws_instance.nomad_client[*].public_ip :
      "ssh -i ~/.ssh/${var.cluster_name}-key ubuntu@${ip}"
    ]
  }
}

output "ssh_example_helper_key" {
  description = "Example SSH commands using the helper key created by scripts (nomad-cluster-key)"
  value = {
    server = "ssh -i ~/.ssh/nomad-cluster-key ubuntu@${aws_instance.nomad_server.public_ip}"
    clients = [for ip in aws_instance.nomad_client[*].public_ip : "ssh -i ~/.ssh/nomad-cluster-key ubuntu@${ip}"]
  }
}

output "cluster_info" {
  description = "Summary of cluster information"
  value = {
    cluster_name = var.cluster_name
    environment  = var.environment
    region       = var.aws_region
    server_count = 1
    client_count = var.client_count
  }
}