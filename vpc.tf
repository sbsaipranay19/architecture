resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_IGW"
  }
}

