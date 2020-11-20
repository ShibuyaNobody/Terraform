resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id   = aws_vpc.race_city.id
  vpc_id        = aws_vpc.big_city.id
  auto_accept   = true

  tags = {
    Name = "VPC Peering between big_city and race_city"
  }
}