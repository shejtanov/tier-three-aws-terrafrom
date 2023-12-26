variable "vpc_id" {
  description = "The VPC ID."
}

variable "public_subnet_ids" {
  description = "The list of subnet IDs for the ALB."
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "The ID of the security group for the ALB."
  type        = string
}