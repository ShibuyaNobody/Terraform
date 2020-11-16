resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.street1.id
}

resource "aws_eip" "nat_eip" {
  vpc = true
}