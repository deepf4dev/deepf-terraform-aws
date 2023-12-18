resource "aws_acm_certificate" "cert" {
  domain_name       = "deepf.io"
  validation_method = "DNS" # ou "EMAIL" si vous préférez la validation par e-mail

  subject_alternative_names = ["www.deepf.io"] # ajoutez des SANs si nécessaire

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      type    = dvo.resource_record_type
      record  = dvo.resource_record_value
      zone_id = "votre-zone-id" # Remplacez par l'ID de votre zone hébergée Route 53
    }
  }

  name    = each.value.name
  type    = each.value.type
  zone_id = each.value.zone_id
  records = [each.value.record]
  ttl     = 60
}



