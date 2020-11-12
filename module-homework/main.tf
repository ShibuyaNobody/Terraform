provider "aws" {
  region = "us-west-1"
}

module "vpc_city_practice" {
  source = "github.com/CSUN-IT/TerraformModules.git/AWS/VPC/v1.0"

  project_name = "big-city"
  vpc_block    = "10.1.1.0/22"

  public_subnet_blocks = {
    "10.1.1.0/24"   = "us-west-1a",
    "10.1.1.256/24" = "us-west-1b"
  }

  private_subnet_blocks = {
    "10.1.1.512/24" = "us-west-1a",
    "10.1.1.768/24" = "us-west-1b"
  }

  private_subnet_gateway = {
    gateway_type    = null,
    additional_tags = {}
  }
}