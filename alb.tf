resource "aws_security_group" "ealb_sg" {
  name        = "Ext-LB-SG"
  description = "load balancer security group"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "LB_SG"
  }
}

resource "aws_lb" "ealb" {
  name               = "ASG-EALB"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public-1a.id, aws_subnet.public-1b.id]
  security_groups    = [aws_security_group.ealb_sg.id]

  tags = {
    name = "External_ALB"
  }
}

resource "aws_lb_target_group" "alb_tg_app1" {
  name     = "Int-ALB-TG-App1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  tags = {
    name = "ALB_TG_App1"
  }
}

resource "aws_lb_listener" "external_alb_listener" {
  load_balancer_arn = aws_lb.ealb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_tg_app1.arn
    type             = "forward"
  }
}
