variable "aws_region" {
  description = "AWS region to deploy to"
  default     = "eu-west-3"
  type        = string
}

variable "bucket_name" {
  description = "Name of the bucket to create"
  default     = "df-frontend-bucket"
  type        = string
}
