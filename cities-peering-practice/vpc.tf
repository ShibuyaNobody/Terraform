module "race_city" {
  source = "github.com/CSUN-IT/TerraformModules.git/AWS/VPC/v1.0"

  project_name = "race-city"
  vpc_block    = "172.28.0.0/16"

  public_subnet_blocks = {
    "172.28.0.0/18"  = "us-west-1a",
    "172.28.64.0/18" = "us-west-1b"
  }

  private_subnet_blocks = {
    "172.28.128.0/18" = "us-west-1a",
    "172.28.192.0/18" = "us-west-1b"
  }

  private_subnet_gateway = {
    gateway_type    = null,
    additional_tags = {}
  }
}

provider "aws" {
  region = "us-west-1"
}

module "big_city" {
  source = "github.com/CSUN-IT/TerraformModules.git/AWS/VPC/v1.0"

  project_name = "big-city"
  vpc_block    = "10.1.0.0/22"

  public_subnet_blocks = {
    "10.1.0.0/24" = "us-west-1a",
    "10.1.1.0/24" = "us-west-1b"
  }

  private_subnet_blocks = {
    "10.1.2.0/24" = "us-west-1a",
    "10.1.3.0/24" = "us-west-1b"
  }

  private_subnet_gateway = {
    gateway_type    = null,
    additional_tags = {}
  }
}