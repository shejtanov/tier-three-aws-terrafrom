resource "aws_ecs_cluster" "cluster" {
  name = "backend-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                   = "backend-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = var.ecs_execution_role_arn

  container_definitions = jsonencode([{
    name  = "backend",
    image = var.backend_image,
    memory = 512,
    cpu = 256,
    essential = true,
    portMappings = [{
      containerPort = 80,
      hostPort      = 80
    }],
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-group"         = "/ecs/backend",
        "awslogs-region"        = var.aws_region,
        "awslogs-stream-prefix" = "ecs"
      }
    }
    // Add environment variables and other necessary configurations
  }])

  # requires_compatibilities = ["EC2"]
  memory                   = "512"
  cpu                      = "256"
}

resource "aws_ecs_service" "service" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "EC2"

  desired_count = 2
  deployment_controller {
    type = "ECS"
  }
}
