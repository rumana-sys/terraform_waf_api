variable "api_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  type        = string
}

variable "alb_arn" {   # Added ALB ARN for VPC Link
  description = "The ARN of the Application Load Balancer"
  type        = string
}

variable "stage_name" {
  description = "The stage name of the API Gateway"
  type        = string
  default     = "prod"
}

