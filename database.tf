resource "aws_dynamodb_table" "alura-db" {
  name         = "alura-db"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"
  range_key    = "nome"
  attribute {
    name = "id"
    type = "S"
  }
  attribute {
    name = "nome"
    type = "S"
  }
}
