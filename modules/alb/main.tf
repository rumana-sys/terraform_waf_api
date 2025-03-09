resource "aws_lb" "external-load" {
  name               = "external-load"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.external_alb_sg.id]
  subnets            = var.public_subnet_cidrs

  #enable_deletion_protection = true  

  /*access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true*/
  }

  resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.external-load.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}

