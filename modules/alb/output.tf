output "alb_arn" {
  value = aws_lb.external-load.arn
}

output "external_alb_sg_id" {
  value = aws_security_group.external_alb_sg.id
}

#Added by rumana
output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.external-load.dns_name
}
