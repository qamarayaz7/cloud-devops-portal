# Single permanent bucket
resource "aws_s3_bucket" "my_website_bucket" {
  bucket = "qamar-devops-portfolio"  # Choose a unique global name
}

# File upload with content tracking
resource "aws_s3_object" "website_file" {
  bucket = aws_s3_bucket.my_website_bucket.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
  
  # Detect when local file changes to trigger updates
  etag = filemd5("index.html")
}

# ... (keep all your website configuration blocks the same)