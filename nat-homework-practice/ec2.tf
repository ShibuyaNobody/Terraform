resource "aws_instance" "bastion_host" {
  ami           = "ami-0947d2ba12ee1ff75"
  instance_type = "t2.micro"

  tags = {
    Name = "bastion-host"
  }
}