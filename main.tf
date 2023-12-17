
provider "aws" {
  region = "eu-west-3"
}

resource "aws_s3_bucket" "hosting_bucket" {
  bucket = "df-frontend-bucket" # Remplacez par le nom unique de votre bucket
  acl    = "private"

  website {
    index_document = "index.html"
    error_document = "error.html"
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
        Resource  = "arn:aws:s3:::mon-bucket-react-app/*"
      }
    ]
  })
}
