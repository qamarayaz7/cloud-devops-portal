resource "aws_s3_bucket" "my_website_bucket" {
  bucket = "qamar-bucket-12"
}

resource "aws_s3_bucket_website_configuration" "my_website" {
  bucket = aws_s3_bucket.my_website_bucket.id
  index_document {
    suffix = "index.html"
  }
}

# ADD THIS BLOCK - it allows public access
resource "aws_s3_bucket_public_access_block" "my_website" {
  bucket = aws_s3_bucket.my_website_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

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
          aws_s3_bucket.my_website_bucket.arn,
          "${aws_s3_bucket.my_website_bucket.arn}/*",
        ]
      },
    ]
  })
}