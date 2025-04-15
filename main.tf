provider "aws"{
  region = "us-east-1"
}

resource "aws_s3_bucket" "StaticApp" { 
  bucket = "Web_App_Test"

  website {
    index_documnet = "index.html"
    error_documnet = "404.html"
  }

  tegs = {
    project = "StaticApp
   }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })
}

output "website_url" {
  value = aws_s3_bucket.static_site.website_endpoint
}



