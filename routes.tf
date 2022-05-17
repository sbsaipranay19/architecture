resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }
  tags = {
    Name = "Public_Route_Table"
  }
}

resource "aws_route_table_association" "subnet_association_2a" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "subnet_association_2b" {
  subnet_id      = aws_subnet.public-1b.id
  route_table_id = aws_route_table.public_route_table.id
}