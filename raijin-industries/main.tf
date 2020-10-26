provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "raijin_industries_bucket" {
  bucket = "raijin-industries-bucket"

  tags = {
    Purpose = "homework"
  }

  versioning {
    enabled = true
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0e4035ae3f70c400f"
  instance_type = "t2.micro"
  subnet_id     = "subnet-051c1c2a397b8e5e8"
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
  }

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "Raijin EC2 Instance"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-07a7d440775338b55"

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["75.83.65.139/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

locals {
  notification_email_addresses = [
    "shibuyanobody@gmail.com",
    "rachelmarie.delarama.519@my.csun.edu"
  ]
}

resource "aws_budgets_budget" "budget_alert" {
  name              = "budget-alert"
  budget_type       = "COST"
  limit_amount      = "10"
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2020-10-21_00:00"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 50
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = local.notification_email_addresses
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 75
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = local.notification_email_addresses
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 90
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = local.notification_email_addresses
  }
}