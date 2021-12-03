locals {
  tags = {
    CreatedBy = "Terraform"
    Owner     = var.owner
  }
}

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {}
}


module "network" {
  source  = "./network"
  project = var.project
  stage   = var.stage
  region  = var.region
  tags    = local.tags
}

module "loadbalancer" {
  source = "./loadbalancer"

  vpc_id                        = module.network.vpc_id
  additional_security_group_ids = []
  subnet_ids                    = module.network.subnet_ids

  project = var.project
  stage   = var.stage
  region  = var.region
  tags    = local.tags
}

module "lambda" {
  source = "./lambda-attribute"

  s3_buckets = ["arn:aws:s3:::tme-tf-state"]

  project = var.project
  stage   = var.stage
  region  = var.region
  tags    = local.tags
}