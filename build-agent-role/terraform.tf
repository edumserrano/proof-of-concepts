terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.5.5"
}

provider "aws" {
  region = "us-west-2" # london
}
