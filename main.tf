# Configure the AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Create S3 bucket with unique name
resource "aws_s3_bucket" "my_website_bucket" {
  bucket_prefix = "qamar-devops-"
}

# Upload website file to the bucket
resource "aws_s3_object" "website_file" {
  bucket = aws_s3_bucket.my_website_bucket.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
}

# Configure the bucket as a website
resource "aws_s3_bucket_website_configuration" "my_website" {
  bucket = aws_s3_bucket.my_website_bucket.id

  index_document {
    suffix = "index.html"
  }
}

# Allow public access to the bucket
resource "aws_s3_bucket_public_access_block" "my_website" {
  bucket = aws_s3_bucket.my_website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Create policy to allow public read access
resource "aws_s3_bucket_policy" "allow_public_read" {
  bucket = aws_s3_bucket.my_website_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          "${aws_s3_bucket.my_website_bucket.arn}/*",
        ]
      },
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.my_website]
}

# Output the website URL
output "website_url" {
  value = "http://${aws_s3_bucket.my_website_bucket.bucket}.s3-website-us-east-1.amazonaws.com"
}