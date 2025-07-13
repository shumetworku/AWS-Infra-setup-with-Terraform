resource "aws_eip" "nat_eip" {
  count = length(var.cidr_private_subnet)
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  count      = length(var.cidr_private_subnet)
  depends_on = [aws_eip.nat_eip]
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id = aws_subnet.aws_test_private_subnets[count.index].id
  tags = {
    "Name" = "NAT_GW: For test Project "
  }
}