# Main Terraform configuration for Nomad cluster deployment
# Student project implementation

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "NomadCluster"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Student     = "KoushalSharma"
    }
  }
}

# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# VPC and Networking
resource "aws_vpc" "nomad_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}

resource "aws_internet_gateway" "nomad_igw" {
  vpc_id = aws_vpc.nomad_vpc.id

  tags = {
    Name = "${var.cluster_name}-igw"
  }
}

resource "aws_subnet" "nomad_subnet" {
  count = min(length(data.aws_availability_zones.available.names), 2)

  vpc_id                  = aws_vpc.nomad_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.cluster_name}-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "nomad_rt" {
  vpc_id = aws_vpc.nomad_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nomad_igw.id
  }

  tags = {
    Name = "${var.cluster_name}-rt"
  }
}

resource "aws_route_table_association" "nomad_rta" {
  count = length(aws_subnet.nomad_subnet)

  subnet_id      = aws_subnet.nomad_subnet[count.index].id
  route_table_id = aws_route_table.nomad_rt.id
}

# Security Groups
resource "aws_security_group" "nomad_server" {
  name_prefix = "${var.cluster_name}-server-"
  vpc_id      = aws_vpc.nomad_vpc.id

  # Nomad server ports
  ingress {
    from_port   = 4646
    to_port     = 4648
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  # HTTP for UI (will be secured with basic auth)
  ingress {
    from_port   = 4646
    to_port     = 4646
    protocol    = "tcp"
    cidr_blocks = var.allowed_ui_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-server-sg"
  }
}

resource "aws_security_group" "nomad_client" {
  name_prefix = "${var.cluster_name}-client-"
  vpc_id      = aws_vpc.nomad_vpc.id

  # Nomad client ports
  ingress {
    from_port   = 4646
    to_port     = 4648
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # Dynamic port range for allocations
  ingress {
    from_port   = 20000
    to_port     = 32000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  # HTTP access for applications
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-client-sg"
  }
}

# Key Pair for SSH access
resource "aws_key_pair" "nomad_key" {
  key_name   = "${var.cluster_name}-key"
  public_key = var.ssh_public_key
}

# IAM role for instances (basic permissions)
resource "aws_iam_role" "nomad_instance_role" {
  name = "${var.cluster_name}-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "nomad_instance_profile" {
  name = "${var.cluster_name}-instance-profile"
  role = aws_iam_role.nomad_instance_role.name
}

# Nomad Server Instance
resource "aws_instance" "nomad_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.server_instance_type
  key_name               = aws_key_pair.nomad_key.key_name
  vpc_security_group_ids = [aws_security_group.nomad_server.id]
  subnet_id              = aws_subnet.nomad_subnet[0].id
  iam_instance_profile   = aws_iam_instance_profile.nomad_instance_profile.name

  user_data = templatefile("${path.module}/user_data_server.sh", {
    cluster_name = var.cluster_name
    environment  = var.environment
  })

  tags = {
    Name = "${var.cluster_name}-server"
    Type = "nomad-server"
  }
}

# Nomad Client Instances
resource "aws_instance" "nomad_client" {
  count = var.client_count

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.client_instance_type
  key_name               = aws_key_pair.nomad_key.key_name
  vpc_security_group_ids = [aws_security_group.nomad_client.id]
  subnet_id              = aws_subnet.nomad_subnet[count.index % length(aws_subnet.nomad_subnet)].id
  iam_instance_profile   = aws_iam_instance_profile.nomad_instance_profile.name

  user_data = templatefile("${path.module}/user_data_client.sh", {
    cluster_name   = var.cluster_name
    environment    = var.environment
    server_address = aws_instance.nomad_server.private_ip
  })

  tags = {
    Name = "${var.cluster_name}-client-${count.index + 1}"
    Type = "nomad-client"
  }
}