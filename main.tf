
resource "aws_s3_bucket" "hosting_bucket" {
  bucket = "df-frontend-bucket"
}

resource "aws_s3_bucket_website_configuration" "hosting_bucket_website" {
  bucket = aws_s3_bucket.hosting_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}


resource "aws_s3_bucket_policy" "hosting_bucket_policy" {
  bucket = aws_s3_bucket.hosting_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.hosting_bucket.id}/*"
      }
    ]
  })
}
