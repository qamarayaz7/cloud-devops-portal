# 1. CREATE THE BUCKET (THE EMPTY BOX)
resource "aws_s3_bucket" "my_website_bucket" {
  bucket_prefix = "qamar-devops-"
}

# 2. MAKE IT A WEBSITE (TURN ON WEBSITE MODE)
resource "aws_s3_bucket_website_configuration" "my_website" {
  bucket = aws_s3_bucket.my_website_bucket.id  # <-- CONNECTS TO THE BUCKET

  index_document {
    suffix = "index.html"  # <-- TELLS AWS: "SHOW index.html AS HOME PAGE"
  }
}

# 3. UNLOCK THE DOOR (ALLOW PUBLIC ACCESS)
resource "aws_s3_bucket_public_access_block" "my_website" {
  bucket = aws_s3_bucket.my_website_bucket.id  # <-- CONNECTS TO THE BUCKET

  block_public_acls       = false  # <-- "DON'T BLOCK PUBLIC ACCESS"
  block_public_policy     = false  # <-- "DON'T BLOCK PUBLIC POLICIES"
  ignore_public_acls      = false  # <-- "DON'T IGNORE PUBLIC REQUESTS"
  restrict_public_buckets = false  # <-- "DON'T RESTRICT PUBLIC BUCKETS"
}

# 4. PUT UP THE WELCOME SIGN (ALLOW EVERYONE TO READ)
resource "aws_s3_bucket_policy" "allow_public_read" {
  bucket = aws_s3_bucket.my_website_bucket.id  # <-- CONNECTS TO THE BUCKET
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"        # <-- "ALLOW PEOPLE TO..."
        Principal = "*"            # <-- "EVERYONE"
        Action    = "s3:GetObject" # <-- "VIEW FILES"
        Resource = [
          "${aws_s3_bucket.my_website_bucket.arn}/*",  # <-- "IN THIS BUCKET"
        ]
      },
    ]
  })
}

# 5. GET THE ADDRESS (SHOW YOU THE WEBSITE URL)
output "website_url" {
  value = "http://${aws_s3_bucket.my_website_bucket.bucket}.s3-website-us-east-1.amazonaws.com"
}