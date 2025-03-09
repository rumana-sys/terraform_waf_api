terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.6.6"
}

# To create the resources in the specified region
provider "aws" {
  region = var.aws_region
}

# To run the VPC module
module "vpc" {
  source = "./modules/vpc"
  aws_region = var.aws_region
  vpc_cidr_block = var.vpc_cidr_block
  availability_zones = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
  frontend_subnet_cidrs = var.frontend_subnet_cidrs
  backend_subnet_cidrs = var.backend_subnet_cidrs
  data_subnet_cidrs = var.data_subnet_cidrs
  }

  module "targetgroups" {
  source   = "./modules/targetgroups"
  vpc_id    = module.vpc.vpc_id
}

module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidrs = module.vpc.public_subnet_ids
  target_group_arn    = module.targetgroups.target_group_arn
}

module "fargate" {
  source            = "./modules/fargate"
  vpc_id            = module.vpc.vpc_id
  frontend_subnet1  = module.vpc.frontend_subnet1
  frontend_subnet2  = module.vpc.frontend_subnet2  
  backend_subnet1   = module.vpc.backend_subnet1
  backend_subnet2   = module.vpc.backend_subnet2  
  target_group_arn   = module.targetgroups.target_group_arn
  alb_security_group_id = module.alb.external_alb_sg_id
}

#Added by rumana
module "api_gateway" {
  source       = "./modules/api_gateway"
  api_name     = var.api_name
  stage_name   = var.stage_name
  alb_arn      = module.alb.alb_arn   # Pass ALB ARN correctly
  alb_dns_name = module.alb.alb_dns_name  # Pass ALB DNS Name correctly
}

module "waf" {
  source = "./modules/waf"
  waf_name = var.waf_name
  api_gateway_stage_arn = module.api_gateway.api_gateway_stage_arn
}
