resource "aws_security_group" "security_group" {
name = "allow-all-sg"
vpc_id = aws_vpc.vpc.id
# BE AWARE THAT THE CURRENT SETTING ALLOW SSH CONNECTION FROM EVERYWHERE
# FOR SECURITY REASONS PLEASE CONCIDER CHANGING THIS BEHAVIOR
  ingress {
    description = "SSH"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
// Required for HVN connexion
  egress {
    description = "Athorise connexion to HVN Vault"
    from_port = 8200
    to_port = 8200
    protocol = "tcp"
    cidr_blocks = [var.hvn_cidr_block]
 }
// Terraform removes the default rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}