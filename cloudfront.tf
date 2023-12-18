resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.df-frontend-bucket.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.df-frontend-bucket.id}"
  }

  enabled             = true
  default_root_object = "index.html"

  aliases = ["deepf.io"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.bucket.id}"

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
    acm_certificate_arn            = "arn:aws:acm:eu-west-3:967651037590:certificate/b3ad496f-fac2-4017-a143-2293bd4bb97d" # Remplacez par votre ARN de certificat
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2018"
  }
}
