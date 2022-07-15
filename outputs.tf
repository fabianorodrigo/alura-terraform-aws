# print do IP da instância criada
output "ips" {
  value = "${aws_instance.dev[0].public_ip}, ${aws_instance.dev[1].public_ip}, ${aws_instance.dev[2].public_ip}"
}
