# Terraform AWS EC2 with reusable modules

This project creates:
- A custom VPC
- One public subnet
- An Internet Gateway and default route
- A security group allowing SSH only from your configured public IP
- One Amazon Linux 2023 EC2 instance
- One Elastic IP

Default region: `ap-south-1` (Mumbai).

## Prerequisites

- Terraform 1.5 or later
- AWS CLI configured with credentials
- AWS permissions to create VPC, subnet, route table, Internet Gateway,
  security group, EC2 instance, Elastic IP, and read the public SSM parameter

## Configure

Copy the example variables file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` and replace `my_ip_cidr` with your current public IP
in `/32` notation. Do not use `0.0.0.0/0` for SSH.

The project looks up the latest Amazon Linux 2023 x86_64 AMI using the public
AWS Systems Manager parameter for the selected region.

## Deploy

```bash
aws sts get-caller-identity
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
terraform output
```

## Connect

Use the Elastic IP shown by `terraform output ec2_public_ip`. This configuration
does not create an SSH key pair. To connect using SSH, create/select a key pair
in the AWS console and add its name as a `key_name` input to the EC2 module,
or extend the module to create/use a key pair. Alternatively, use AWS Systems
Manager Session Manager after configuring the required instance IAM role and
permissions.

## Clean up

```bash
terraform destroy
```

Check the AWS Billing console after cleanup for any resources left outside
Terraform or any charges already incurred.

## Cost and security notes

- An Elastic IP/public IPv4 address can incur charges. Review current AWS
  public IPv4 and EC2 pricing for your region and account eligibility.
- EC2 and EBS charges depend on instance type, usage, region, and Free Tier
  eligibility. `t3.micro` is not guaranteed to be free for every account/offer.
- SSH is restricted to the single IPv4 CIDR you configure.
- IMDSv2 is required and the root EBS volume is encrypted.
- This is a learning example, not a hardened production baseline.
