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
  port     = "${var.server_port}"
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  tags = {
    name = "ALB_TG_App1"
  }
}

resource "aws_lb_listener" "external_alb_listener" {
  load_balancer_arn = aws_lb.ealb.arn
  port              = "${var.server_port}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_tg_app1.arn
    type             = "forward"
  }
}

resource "aws_alb_target_group_attachment" "web-tga1" {
  target_group_arn = aws_lb_target_group.alb_tg_app1.arn
  target_id = aws_instance.example-1b.id
  port = "${var.server_port}"
}

resource "aws_alb_target_group_attachment" "web-tga2" {
  target_group_arn = aws_lb_target_group.alb_tg_app1.arn
  target_id = aws_instance.example-1a.id
  port = "${var.server_port}"
}
MG
