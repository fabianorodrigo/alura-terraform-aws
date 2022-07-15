// variável do tipo 'map' com os diferentes códigos de imagem por região
variable "amis" {
  type = map(string)
  default = {
    "us-east-1" : "ami-08d4ac5b634553e16",
    "us-east-2" : "ami-08d4ac5b634553e16",
  }
}

variable "cdirs_blocks_acesso_remoto" {
  type    = list(string)
  default = ["189.40.94.62/32", "45.180.54.252/32"]
}

variable "key_name" {
  default = "alura-terraform-aws"
}
