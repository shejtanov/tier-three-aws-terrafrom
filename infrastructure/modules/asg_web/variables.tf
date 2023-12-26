variable "web_ami_id" {
  description = "The AMI ID for the web instances."
}

variable "web_instance_type" {
  description = "The instance type for the web instances."
  default     = "t3.micro"
}

variable "web_subnet_ids" {
  description = "The list of subnet IDs for the web ASG."
  type        = list(string)
}

variable "web_asg_min_size" {
  description = "The minimum size of the web ASG."
  default     = 1
}

variable "web_asg_max_size" {
  description = "The maximum size of the web ASG."
  default     = 3
}

variable "web_asg_desired_capacity" {
  description = "The desired capacity of the web ASG."
  default     = 2
}