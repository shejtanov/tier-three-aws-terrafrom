output "frontend_distribution_id" {
  value = aws_cloudfront_distribution.frontend_distribution.id
}

output "frontend_distribution_domain_name" {
  value = aws_cloudfront_distribution.frontend_distribution.domain_name
}
