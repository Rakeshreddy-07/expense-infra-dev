data "aws_cloudfront_cache_policy" "noCache" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "cacheEnable" {
  name = "Managed-CachingOptimized"
}

data "aws_ssm_parameter" "https_certificate_arn" {
  name = "/${var.project}/${var.environment}/acm_expense_arn"
}