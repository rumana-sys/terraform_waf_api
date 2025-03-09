output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}


# Added by Rumana
output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = module.alb.alb_arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "api_gateway_id" {
  description = "The ID of the API Gateway"
  value       = module.api_gateway.api_gateway_id
}

output "waf_acl_arn" {
  description = "The ARN of the WAF Web ACL"
  value       = module.waf.waf_acl_arn
}

