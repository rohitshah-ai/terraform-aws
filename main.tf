terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Latest Amazon Linux 2023 x86_64 AMI in the selected region.
data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name    = var.vpc_name
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
  az          = var.availability_zone
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id   = module.vpc.vpc_id
  sg_name  = "${var.instance_name}-sg"
  ssh_cidr = var.my_ip_cidr
}

module "ec2" {
  source = "./modules/ec2"

  ami_id        = data.aws_ssm_parameter.amazon_linux.value
  instance_type = var.instance_type
  instance_name = var.instance_name
  subnet_id     = module.vpc.subnet_id
  sg_id         = module.security_group.sg_id
}
