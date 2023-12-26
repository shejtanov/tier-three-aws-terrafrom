resource "aws_ecr_repository" "backend" {
  name                 = "backend-repo" // Name of the service
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}