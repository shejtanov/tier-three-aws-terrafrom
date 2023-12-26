output "web_alb_arn" {
  description = "The ARN of the web application load balancer"
  value       = aws_lb.web_alb.arn
}

output "web_alb_dns_name" {
  description = "The DNS name of the web application load balancer"
  value       = aws_lb.web_alb.dns_name
}

output "web_tg_arn" {
  description = "The ARN of the web target group"
  value       = aws_lb_target_group.web_tg.arn
}

output "alb_sg_id" {
  description = "The ID of the ALB security group"
  value       = aws_security_group.alb_sg.id
}
