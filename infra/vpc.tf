variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}

locals {
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.66.0"

  name                 = "sample-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.10.0/24"]
  public_subnets       = ["10.0.11.0/24"]
  enable_nat_gateway   = false
  # single_nat_gateway   = false
  enable_dns_hostnames = true

  tags = {
    "application" = "minecraft"
  }

  public_subnet_tags = {	
  }

  private_subnet_tags = {
  }
}