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
  key_name = var.key_name
  # tags para identificar os recursos criados
  tags = {
    # name com sufixo do número da máquina (1, 2 ou 3)
    Name = "AluraTerraform${count.index}"
  }
  # associação das instâncias com o Security Group 'acesso_ssh' 
  # OBS: ele retira outros grupos que por ventura já estejam associados
  # mantendo apenas o array
  vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"]
}

# criação instância EC2 chamada 'devComBucket'
resource "aws_instance" "devComBucket" {
  # Amazon Machine Image do Ubuntu Server 20.04 LTS (HVM), SSD Volume Type (X86)
  ami = "ami-08d4ac5b634553e16"
  # tipo de instância com 1 vCPU e 1GB de memória (Free tier eligigle)
  instance_type = "t2.micro"
  # Nome da chave (gerada localmetne com ssh-keygen) importada na AWS Console/EC2 e que será
  # utilizada para se autenticar nesta máquina quando criada
  key_name = var.key_name
  # tags para identificar os recursos criados
  tags = {
    Name = "AluraTerraformDevComBucket"
  }
  # associação das instâncias com o Security Group 'acesso_ssh' 
  # OBS: ele retira outros grupos que por ventura já estejam associados
  # mantendo apenas o array
  vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"]
  # cria vínculo com o bucket criado acima
  depends_on = [
    aws_s3_bucket.alura-bucket
  ]
}


# criação máquina do ambiente HOMOLOGAÇÃO
resource "aws_instance" "hml" {
  # Amazon Machine Image do Ubuntu Server 20.04 LTS (HVM), SSD Volume Type (X86)
  ami = var.amis["us-east-1"]
  # tipo de instância com 1 vCPU e 1GB de memória (Free tier eligigle)
  instance_type = "t2.micro"
  # Nome da chave (gerada localmente com ssh-keygen) importada na AWS Console/EC2 e que será
  # utilizada para se autenticar nesta máquina quando criada
  key_name = var.key_name
  # tags para identificar os recursos criados
  tags = {
    Name = "hml"
  }
  # associação das instâncias com o Security Group 'acesso_ssh' 
  # OBS: ele retira outros grupos que por ventura já estejam associados
  # mantendo apenas o array
  vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"]
  depends_on = [
    aws_dynamodb_table.alura-db
  ]
}
