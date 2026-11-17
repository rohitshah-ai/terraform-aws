variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "ap-south-1"
}

variable "availability_zone" {
  description = "Availability Zone for the public subnet"
  type        = string
  default     = "ap-south-1a"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "dev-vpc"
}

variable "vpc_cidr" {
  description = "VPC IPv4 CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Public subnet IPv4 CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type; confirm current Free Tier eligibility"
  type        = string
  default     = "t3.micro"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "dev-ec2-instance"
}

variable "my_ip_cidr" {
  description = "Your public IPv4 address in CIDR notation, e.g. 198.51.100.25/32"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.my_ip_cidr))
    error_message = "my_ip_cidr must be a valid IPv4 CIDR, ideally your public IP with /32."
  }
}
