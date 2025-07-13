resource "aws_internet_gateway" "public_internet_gateway" {
  vpc_id = aws_vpc.vpc-test-us-east-1.id
  tags = {
    Name = "IGW: For test Project"
  }
}