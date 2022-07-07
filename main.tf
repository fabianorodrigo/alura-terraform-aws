terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# definindo o provider AWS com a região
provider "aws" {
  region = "us-east-1"
}

# criação instância EC2 chamada 'dev'
resource "aws_instance" "dev" {
  # estabelece o número de instâncias a se criar
  count = 3
  # Amazon Machine Image do Ubuntu Server 20.04 LTS (HVM), SSD Volume Type (X86)
  ami = "ami-08d4ac5b634553e16"
  # tipo de instância com 1 vCPU e 1GB de memória (Free tier eligigle)
  instance_type = "t2.micro"
  # Nome da chave (gerada localmetne com ssh-keygen) importada na AWS Console/EC2 e que será
  # utilizada para se autenticar nesta máquina quando criada
  key_name = "alura-terraform-aws"
  # tags para identificar os recursos criados
  tags = {
    # name com sufixo do número da máquina (1, 2 ou 3)
    Name = "AluraTerraform${count.index}"
  }
}

# Criação de um Security Group para permitir o acesso SSH nas instâncias criadas
resource "aws_security_group" "acesso_ssh" {
  name        = "acesso_ssh"
  description = "acesso_ssh"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # restringindo o acesso a um IP específico
    cidr_blocks = ["189.40.94.62/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "acesso_ssh"
  }
}
