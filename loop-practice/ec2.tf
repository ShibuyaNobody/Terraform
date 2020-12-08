provider "aws" {
  region = "us-west-1"
}

# locals {
#   instances_to_create = {
#     hostname1 = "instance1"
#     hostname2 = "instance2"
#   }
# }

variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-0dac9de06ce73c092",
    "subnet-0f35ece57b362f245"
    ]
}

resource "aws_instance" "instances" {
  count = length(var.subnet_ids)

  ami           = "ami-0e4035ae3f70c400f"
  instance_type = "t2.micro"
  # tags          = { Name = each.value }
  subnet_id     = var.subnet_ids[count.index]

  vpc_security_group_ids = ["sg-062e5daf93e403801"]

}