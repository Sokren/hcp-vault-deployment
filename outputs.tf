output "vault_private_endpoint_url" {
  description = "URL of the private endpoint"
  value = {for k, v in module.vault_deployment: k => v.vault_private_endpoint_url}
}

output "vault_public_endpoint_url" {
  description = "URL of the public endpoint"
  value = {for k, v in module.vault_deployment: k => v.vault_public_endpoint_url}
}

output "ec2_public_dns" {
  description = "Public DNS of the EC2"
  value = {for k, v in aws_instance.my_instance: k => v.public_dns}
}

output "ec2_public_ip" {
  description = "Public IP of the EC2"
  value = {for k, v in aws_instance.my_instance: k => v.public_ip}
}

output "vpc_id" {
  description = "ID of VPC"
  value = aws_vpc.vpc.id
}