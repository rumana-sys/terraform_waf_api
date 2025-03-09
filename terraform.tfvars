aws_region = "ca-central-1"

vpc_cidr_block = "10.0.0.0/16"

availability_zones = ["ca-central-1a", "ca-central-1b"]

public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

frontend_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

backend_subnet_cidrs = ["10.0.5.0/24", "10.0.6.0/24"]

data_subnet_cidrs = ["10.0.7.0/24", "10.0.8.0/24"]

#added by Rumana
alb_dns_name = "alb_dns_name"      # Replace with actual ALB DNS name
api_name = "blynk-api"
stage_name = "dev"
waf_name = "blynk-waf"