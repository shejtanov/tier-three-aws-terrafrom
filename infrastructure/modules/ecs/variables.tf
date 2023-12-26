variable "aws_region" {
  description = "The AWS region to deploy into"
  default     = "us-east-1"
}

variable "ecs_execution_role_arn" {
  description = "ARN of the IAM role that the ECS service will assume."
}

variable "backend_image" {
  description = "The backend Docker image to use in the ECS service."
}
