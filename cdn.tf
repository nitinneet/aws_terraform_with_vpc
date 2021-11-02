################### Creating S3 Bucket ######################
resource "aws_s3_bucket" "b" {
    bucket = "${var.bucket_name}"
    acl = "${var.acl_value}"
}

locals {
  s3_origin_id = "${var.bucket_name}"
}


##################### Creating CDN ##########################
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.b.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

  }

  enabled             = true
#  is_ipv6_enabled     = true
#  comment             = "Some comment"
#  default_root_object = "index.html"

#  logging_config {
#    include_cookies = false
#    bucket          = "mylogs.s3.amazonaws.com"
#    prefix          = "myprefix"
#  }

#  aliases = ["mysite.example.com", "yoursite.example.com"]

####################### Creating Behavior ####################
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with static content
  ordered_cache_behavior {
    path_pattern     = "${var.static_name}"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "allow-all"
  }

  # Cache behavior with media content
  ordered_cache_behavior {
    path_pattern     = "${var.media_name}"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "allow-all"
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "var.env"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
