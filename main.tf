terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
    region     = var.aws_region
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnet" "mnl_subnet" {
  vpc_id            = data.aws_vpc.default_vpc.id
  availability_zone = "ap-southeast-1-mnl-1a"
}

resource "aws_security_group" "dev_sg" {
  name        = "dev_sg"
  description = "SG for dev purposes, only allows SSH to instance"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress {
      protocol     = "TCP"
      from_port    = 22
      to_port      = 22
      cidr_blocks  = var.aws_allowed_ips
      description  = "Allow SSH"
  }
}

resource "aws_key_pair" "dev_ssh" {
    key_name   = "dev_ssh"
    public_key = var.aws_ssh_key
}

resource "aws_instance" "dev_linux_x64" {
  ami                         = "ami-0588c11374527e516"

  instance_type               = "t3.xlarge"

  key_name                    = aws_key_pair.dev_ssh.key_name

  subnet_id                   = data.aws_subnet.mnl_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.dev_sg.id]

  tags = {
    Name = "dev_linux_x64"
  }

  root_block_device {
    volume_size = 250
    volume_type = "gp2"
  }
}
