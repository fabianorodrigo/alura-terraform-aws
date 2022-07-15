
resource "aws_s3_bucket" "alura-bucket" {
  bucket = "alura-bucket"
  acl    = "private"

  tags = {
    Name = "alura-bucket"
  }
}
