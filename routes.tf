resource "aws_route_table" "private-r-sb1" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "private-rt-sb1"
  }
}

resource "aws_route_table" "private-r-sb2" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "private-rt-sb2"
  }
}

resource "aws_route_table" "public-r-sb1" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = "public-rt-sb1"
  }
}

resource "aws_route_table" "public-r-sb2" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = "public-rt-sb2"
  }
}

resource "aws_route_table_association" "private-rt-sb1" {

  subnet_id = aws_subnet.private-1a.id
  route_table_id = aws_route_table.private-r-sb1.id

}

resource "aws_route_table_association" "public-rt-sb1" {

  subnet_id = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public-r-sb1.id

}

resource "aws_route_table_association" "private-rt-sb2" {

  subnet_id = aws_subnet.private-1b.id
  route_table_id = aws_route_table.private-r-sb2.id

}

resource "aws_route_table_association" "public-rt-sb2" {

  subnet_id = aws_subnet.public-1b.id
  route_table_id = aws_route_table.public-r-sb2.id
  
}



