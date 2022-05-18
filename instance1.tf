provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "example-1a" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  subnet_id            = aws_subnet.private-1a.id

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  tags = {
    Name = "ec2-instance-1a"
  }
    availability_zone = "us-east-2a"
}

resource "aws_instance" "example-1b" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  subnet_id            = aws_subnet.private-1b.id

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF
  tags = {
    Name = "ec2-instance-1b"
  }
  availability_zone = "us-east-2b"
}

