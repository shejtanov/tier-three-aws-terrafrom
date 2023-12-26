output "web_asg_name" {
  description = "The name of the web ASG"
  value       = aws_autoscaling_group.web_asg.name
}