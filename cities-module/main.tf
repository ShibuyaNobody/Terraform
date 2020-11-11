module "vpc_city_practice" {
    source = "github.com/CSUN-IT/TerraformModules.git/AWS/VPC/v1.0"

    project_name = "vpc-city"
    vpc_block = "192.168.1.0/24"

    public_subnet_blocks = {
        "192.168.1.0/26" = "us-west-1a",
        "192.168.1.64/26" = "us-west-1b"
    }

    private_subnet_blocks = {
        "192.168.1.128/26" = "us-west-1a",
        "192.168.1.192/26" = "us-west-1b"
    }

    private_subnet_gateway = {}
}