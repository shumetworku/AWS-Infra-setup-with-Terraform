data "aws_subnet" "public_subnet" {
  filter {
    name = "tag:Name"
    values = ["Subnet-Public : Public Subnet 1"]
  }

  depends_on = [
    aws_route_table_association.public_subnet_association
  ]
}

resource "aws_instance" "ec2_test" {
  ami = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  tags = {
    Name = "EC2 Pub-sub-1"
  }
  key_name= "aws_key"
  subnet_id = data.aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.sg_vpc_test_us_east_1.id]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa (your machine public key-helps to access the instance) shumet"
}


output "fetched_info_from_aws" {
  value = format("%s%s","ssh -i /Users/shumet/.ssh/private_key ubuntu@",aws_instance.ec2_test.public_dns)
}