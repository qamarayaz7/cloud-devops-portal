terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "qamar-devops-portfolio-729"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
    
    # These will use the same AWS credentials you already have
  }
}

provider "aws" {
  region = "us-east-1"
}