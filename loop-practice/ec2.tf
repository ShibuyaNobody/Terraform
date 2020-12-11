provider "aws" {
  region = "us-west-1"
}

variable "subnet_ids" {
  description = "List of private subnets"
  default = [
    "subnet-0dac9de06ce73c092",
    "subnet-0f35ece57b362f245"
  ]
}

variable "instance_name" {
  description = "Create instances with these names"
  type        = list(string)
  default = [
    "instance_1",
    "instance_2"
  ]
}

resource "aws_instance" "instances" {
  count = length(var.subnet_ids)

  ami           = "ami-0e4035ae3f70c400f"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_ids[count.index]
  tags = {
    "Name" = var.instance_name[count.index]
  }

  vpc_security_group_ids = ["sg-062e5daf93e403801"]

}