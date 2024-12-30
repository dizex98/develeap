terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.82.2"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.35.1"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.18.0"
    }
  }

  required_version = ">= 1.3.0"
}

