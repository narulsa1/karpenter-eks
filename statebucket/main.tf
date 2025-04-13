############################################################################################
# Provider
############################################################################################

provider "aws" {
    region              = var.region
    allowed_account_ids = [var.aws_account_id]
}

terraform {
  required_providers {
    aws {
      version = "~> 5.0"
      source = "hashicorp/aws"
    }
  }
}

############################################################################################
# S3 BUcket
############################################################################################

resource "aws_s3_bucket" "state" {
  bucket = "{var.aws_account_id}-bucket-state-file-karpenter"
}