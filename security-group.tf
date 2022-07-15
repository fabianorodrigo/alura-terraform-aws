# Criação de um Security Group para permitir o acesso SSH nas instâncias criadas
resource "aws_security_group" "acesso_ssh" {
  name        = "acesso_ssh"
  description = "acesso_ssh"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # restringindo o acesso a um conjunto de IPs específicos
    cidr_blocks = var.cdirs_blocks_acesso_remoto
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
