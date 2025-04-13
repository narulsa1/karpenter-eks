############################################################################################
# Provider
############################################################################################

provider "aws" {
    region              = var.region
    allowed_account_ids = [var.aws_account_id]
}

terraform {
  backend "s3" {
    bucket = "your_bucket_name"
    region = "ap-south-1"
    key    = "karpenter.tfstate"
       
  }
  required_providers {
    aws {
      version = "~> 5.0"
      source = "hashicorp/aws"
    }
  }
}

############################################################################################
# VPC
############################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  intra_subnets   = ["10.0.104.0/24", "10.0.105.0/24", "10.0.106.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = true

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    # tags subnets for karpenter auto-discovery
    "karpenter.sh/discovery = var.cluster_name
  }

}