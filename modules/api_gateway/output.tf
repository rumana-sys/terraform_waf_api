output "api_gateway_id" {
  description = "The ID of the API Gateway"
  value       = aws_api_gateway_rest_api.api.id
}

output "api_gateway_stage_arn" {
  description = "The ARN of the API Gateway stage (needed for WAF)"
  value       = aws_api_gateway_stage.stage.arn
}