## Create EC2 instance
## Customize with your needs.
resource "aws_instance" "my_instance" {
  for_each = toset(var.listEC2)
  ami           = "ami-08ca3fed11864d6bb"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.my_subnet.id
  vpc_security_group_ids = [ aws_security_group.security_group.id ]
  associate_public_ip_address = true
  tags = {
    Name = "${each.value} - My Instance"
    environment = "demo"
    owner = "OWNER_NAME"
  }
  depends_on = [aws_subnet.my_subnet,aws_security_group.security_group]
}