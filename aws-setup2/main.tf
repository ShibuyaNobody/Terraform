provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "web" {
  ami           = "ami-000279759c4819ddf"
  instance_type = "t2.micro"
  subnet_id = "subnet-0dac9de06ce73c092"


  tags = {
    Name = "Cabbage_Corp"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage = 20
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t2.micro"
  name              = "mydb"
  username          = "merchant"
  password          = "mycabbages"
  db_subnet_group_name = aws_db_subnet_group.default.id
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = ["subnet-0dac9de06ce73c092", "subnet-0f35ece57b362f245"]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_s3_bucket" "cabbage_corp" {
  bucket = "cabbage-corp"

  tags = {
    Purpose = "homework"
  }

  versioning {
    enabled = true
  }
}

locals {
  notification_email_addresses = [
    "shibuyanobody@gmail.com",
    "rachelmarie.delarama.519@my.csun.edu"
  ]
}

resource "aws_budgets_budget" "ec2" {
  name              = "budget-ec2-monthly"
  budget_type       = "COST"
  limit_amount      = "1200"
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2017-07-01_00:00"
  time_unit         = "MONTHLY"

  cost_filters = {
    Service = "Amazon Elastic Compute Cloud - Compute"
  }

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