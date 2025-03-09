resource "aws_api_gateway_rest_api" "api" {                                #Define the API Gateway
  name        = var.api_name
  description = "REST API for E-commerce platform-Blynk"
}

resource "aws_api_gateway_resource" "proxy" {                              #Create a Proxy Resource
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_method" {                           #Create an API Method (ANY Request)
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

# Removed the aws_api_gateway_vpc_link because it's not needed for ALB

resource "aws_api_gateway_integration" "alb_integration" {                       #Integrate API Gateway with ALB
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.proxy_method.http_method
  type                    = "HTTP_PROXY"    # Using HTTP_PROXY for ALB integration
  integration_http_method = "ANY"           # Match with ALB method
  uri                     = "http://${var.alb_dns_name}"  # Direct ALB URL (DNS name)
  connection_type         = "INTERNET"      # Use INTERNET for public ALB
}

resource "aws_api_gateway_method_response" "proxy_response" {                   #Configure API Gateway Responses
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.proxy_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "proxy_integration_response" {   #Handle Integration Responses
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.proxy_method.http_method
  status_code = aws_api_gateway_method_response.proxy_response.status_code

  response_templates = {
    "application/json" = ""
  }

  depends_on = [aws_api_gateway_integration.alb_integration]                        # Ensure integration is fully created first
}

resource "aws_api_gateway_deployment" "api_deployment" {                             #Deploy API Gateway
  depends_on  = [
    aws_api_gateway_method.proxy_method,
    aws_api_gateway_integration.alb_integration,
    aws_api_gateway_method_response.proxy_response,
    aws_api_gateway_integration_response.proxy_integration_response
  ]
  rest_api_id = aws_api_gateway_rest_api.api.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api.body))
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id                    #Creates a stage (like dev, prod) for versioning the API.
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.stage_name                                                  #var.stage_name determines the stage name.
}