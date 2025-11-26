# SINGLE permanent bucket - CHANGE THE NUMBER TO BE UNIQUE
resource "aws_s3_bucket" "my_website_bucket" {
  bucket = "qamar-devops-portfolio-729"  # ← CHANGE 729 to any random numbers
  force_destroy = true
}

# This uploads/updates your file - KEY PART FOR UPDATES
resource "aws_s3_object" "website_file" {
  bucket = aws_s3_bucket.my_website_bucket.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
  
  # THIS ensures Terraform detects file changes and updates the bucket
  etag = filemd5("index.html")
}

# ... (keep all the same website config blocks)
resource "aws_s3_bucket_website_configuration" "my_website" {
  bucket = aws_s3_bucket.my_website_bucket.id
  index_document {
    suffix = "index.html"
  }
}

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
          "${aws_s3_bucket.my_website_bucket.arn}/*",
        ]
      },
    ]
  })
}

output "website_url" {
  value = "http://${aws_s3_bucket.my_website_bucket.bucket}.s3-website-us-east-1.amazonaws.com"
}