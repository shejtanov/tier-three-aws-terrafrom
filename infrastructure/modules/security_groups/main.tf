resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security group for ALB that allows HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

# Security group for the web servers
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Security group for web tier EC2 instances"
  vpc_id      = var.vpc_id

  # Allow web servers to receive HTTP traffic from the ALB
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow web servers to initiate outbound traffic to the Internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# Security group for the app servers
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Security group for application tier EC2 instances"
  vpc_id      = var.vpc_id

  # Example rule: Allow app servers to receive traffic from the web tier
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  # Assume that app servers do not need to be accessed from the internet directly
  # Allow app servers to initiate outbound traffic to the Internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
  }
}

# Security group for the database servers
resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Security group for database tier EC2 instances"
  vpc_id      = var.vpc_id

  # Example rule: Allow DB servers to receive traffic from the app tier
  ingress {
    from_port       = 5432 # Assuming PostgreSQL
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  # Databases typically do not initiate traffic to the Internet, so egress could be restricted
  # This is an example of an egress rule that might be adjusted based on your needs
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}