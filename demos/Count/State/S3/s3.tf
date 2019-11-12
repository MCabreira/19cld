resource "aws_s3_bucket" "b" {
  bucket = "19cld-mba-prod"
  acl    = "private"

  tags = {
    Name        = "19cld-mba-prod"
    Environment = "admin"
  }
}
