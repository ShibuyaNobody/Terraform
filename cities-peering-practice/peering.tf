resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id = module.race_city.vpc_id
  vpc_id      = module.big_city.vpc_id
  auto_accept = true

  tags = {
    Name = "VPC Peering between big_city and race_city"
  }
}