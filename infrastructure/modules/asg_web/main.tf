resource "aws_launch_configuration" "web_lc" {
  name_prefix   = "web-lc-"
  image_id      = var.web_ami_id
  instance_type = var.web_instance_type
  security_groups = [module.security_groups.web_sg_id]

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "User data script to install and start web server"
              EOF
}

resource "aws_autoscaling_group" "web_asg" {
  launch_configuration    = aws_launch_configuration.web_lc.id
  vpc_zone_identifier     = var.web_subnet_ids
  min_size                = var.web_asg_min_size
  max_size                = var.web_asg_max_size
  desired_capacity        = var.web_asg_desired_capacity
  health_check_type       = "EC2"
  health_check_grace_period = 300
  force_delete            = true
  target_group_arns       = [module.alb.web_tg_arn]

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}