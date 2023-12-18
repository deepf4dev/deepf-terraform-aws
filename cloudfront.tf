resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "deepf.io"
    origin_id   = "S3-df-cloudfront"
  }

  enabled             = true
  default_root_object = "index.html"

  aliases = ["deepf.io"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-df-cloudfront"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = "arn:aws:acm:us-east-1:123456789012:certificate/your-cert-id" # Remplacez par votre ARN de certificat
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2018"
  }
}
