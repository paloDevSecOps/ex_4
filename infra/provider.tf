terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.66.1"
    }
  }
}

provider "aws" {
  shared_credentials_files = var.shared_credentials_files
  profile                  = var.profile
  region                   = "ap-southeast-1"
}
