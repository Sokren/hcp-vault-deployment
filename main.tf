terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.71.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "hvn_deployment" {
  source  = "Sokren/hvn_deployment/hcp"
  version = "~>0.0.1"
  aws_region = var.aws_region
  aws_vpc_id = aws_vpc.vpc.id
  aws_vpc_owner_id = aws_vpc.vpc.owner_id
  aws_vpc_cidr_block = aws_vpc.vpc.cidr_block
  peer_id = var.peer_id
  hvn_route_id = var.hvn_route_id
  hvn_id = var.hvn_id
  hvn_cidr_block = var.hvn_cidr_block
}

module "vault_deployment" {
  for_each = toset(var.listClusterName)
  source  = "Sokren/vault_deployment/hcp"
  version = "~>0.0.1"
  cluster_id = each.value
  hvn_id = module.hvn_deployment.hvn_id
  pub_endpoint = var.hcpv_pub_endpoint
}