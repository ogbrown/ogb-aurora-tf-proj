
resource "aws_s3_bucket" "example" {
  bucket = "${var.bucket_name}${var.aws_region}"

  tags   = var.tags

}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  depends_on = [aws_s3_bucket.example]
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  
}