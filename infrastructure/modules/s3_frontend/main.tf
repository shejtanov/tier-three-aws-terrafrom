resource "aws_s3_bucket" "frontend" {
  bucket = "my-unique-frontend-app-bucket"  # Ensure this name is unique

  force_destroy = true
}

resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket = aws_s3_bucket.frontend.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "s3:GetObject",
        Effect    = "Allow",
        Resource  = "${aws_s3_bucket.frontend.arn}/*",
        Principal = "*",
        Condition = {
          StringEquals = {
            "aws:Referer": "http://${aws_cloudfront_distribution.frontend_distribution.domain_name}/"
          }
        }
      }
    ]
  })
}
