resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name              = aws_s3_bucket.this.bucket_regional_domain_name
    origin_id                = "websiteOrigin"
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }
  aliases             = ["www.quicklinks.michaeljsorensen.com","quicklinks.michaeljsorensen.com"]
  enabled             = true
  price_class         = "PriceClass_100"
  default_root_object = "index.html"
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.this.arn
    ssl_support_method  = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "websiteOrigin"
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"


  }
}

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "CloudFrontOAC"
  description                       = "This policy will allow only CloudFront to access the S3 origin"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
output "distribution_name" {
  value = aws_cloudfront_distribution.this.domain_name
}