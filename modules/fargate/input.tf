variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

#variable "private_subnets" {
  #description = "List of private subnets"
  #type        = list(string)
#}

variable "frontend_subnet1" {
  description = "Front end private subnet1"
  type        = string
}

variable "frontend_subnet2" {
  description = "Front end private subnet2"
  type        = string
}

variable "backend_subnet1" {
  description = "Back end private subnet1"
  type        = string
}

variable "backend_subnet2" {
  description = "Back end private subnet2"
  type        = string
}

variable "target_group_arn" {
   description = "ARN of the front end target group"
  }

  variable "alb_security_group_id" {
  description = "The security group ID of the ALB"
  type        = string
}