resource "aws_acm_certificate" "this" {
  domain_name               = "quicklinks.max-weitz.com"
  subject_alternative_names = ["www.quicklinks.max-weitz.com"]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.certificate : record.fqdn]
}