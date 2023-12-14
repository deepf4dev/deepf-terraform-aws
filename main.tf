
provider "aws" {
  region = "us-west-3"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "mon-nom-de-bucket-unique"
}
