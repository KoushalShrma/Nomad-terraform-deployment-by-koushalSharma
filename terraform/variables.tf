# Variables for Nomad cluster deployment
# Configured for student-friendly use with sensible defaults

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "Name of the Nomad cluster"
  type        = string
  default     = "nomad-cluster"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "server_instance_type" {
  description = "EC2 instance type for Nomad servers"
  type        = string
  default     = "t3.small"
}

variable "client_instance_type" {
  description = "EC2 instance type for Nomad clients"
  type        = string
  default     = "t3.small"
}

variable "client_count" {
  description = "Number of Nomad client nodes"
  type        = number
  default     = 2
}

variable "ssh_public_key" {
  description = "SSH public key for EC2 instances"
  type        = string
  # Note: This should be provided via terraform.tfvars or environment variable
}

variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"] # For demo purposes - should be restricted in production
}

variable "allowed_ui_cidr" {
  description = "CIDR blocks allowed for UI access"
  type        = list(string)
  default     = ["0.0.0.0/0"] # For demo purposes - should be restricted in production
}