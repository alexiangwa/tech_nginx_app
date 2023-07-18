
# creating an ALB with a targat group and HTTP listener 

resource "aws_lb" "tech_nginx_app_alb" {
  name           = "tech_nginx_app_alb"
  internal           = false
  load_balancer_type = "application"
  subnets        = aws_subnets.tech_nginx_pub_sn.*.id
  security_groups = [aws_security_group.tech_nginx_app_vpc_web.id]
}

resource "aws_alb_target_group" "tech_nginx_app_tg" {
  name        = "tech_nginx_app_tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "alb"
  vpc_id      =  aws_vpc.tech_nginx_app.id


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    protocol            = "HTTP"
    matcher             = "200"
   # path                = var.health_check_path
    interval            = 30
  }
}

#redirecting all incomming traffic from ALB to the target group
resource "aws_alb_listener" "testapp" {
  load_balancer_arn = aws_lb.tech_nginx_app_alb.arn
  port              = "443"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  #enable above 2 if you are using HTTPS listner and change protocal from HTTPS to HTTPS
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tech_nginx_app_tg.arn
  }
}