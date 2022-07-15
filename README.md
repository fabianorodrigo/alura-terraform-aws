Terraform AWS Project
===

1. AWS Console/IAM: cria usuário com direitos administrativos
2. Salva arquivo CSV com credenciais localmente (está no .gitignore)
3. Gera um par de chaves assíncronas: `ssh-keygen -f <nome arquivo chave> -t rsa `
4. Mover 2 arquivos gerados para ~/./ssh/
5. AWS Console/EC2/Network & Security: Importar chave fazendo upload da chave pública 
6. Criar main.tf
7. Iniciar o projeto terraform com `terraform init`
8. Verificar o que será criado (dry-run) `terraform plan`
9. Executar efetivamente o provisionamento `terraform apply`
10. Para apagar um recurso específico `terraform destroy --target <nome do recurso>`