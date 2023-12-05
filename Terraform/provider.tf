terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "github-actions-cicd-project"
    key    = "actions/terraform.tfstate"
    region = "us-east-1"
  }
    
}

provider "aws" {
  region = "us-east-1" 
}

