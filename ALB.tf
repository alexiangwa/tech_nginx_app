
# creating an ALB with a targat group and HTTP listener 

resource "aws_lb" "tech_nginx_app_alb" {
  name           = "techalb"
  internal           = false
  load_balancer_type = "application"
  subnets        = [aws_subnet.tech_nginx_pub_sn1.id, aws_subnet.tech_nginx_pub_sn2.id]
  security_groups = [aws_security_group.tech_nginx_app_vpc_web.id]
}

resource "aws_lb_target_group" "tech_nginx_app_tg" {
  name        = "techtg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      =  aws_vpc.tech_nginx_app.id


#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     protocol            = "HTTP"
#     matcher             = "200"
#    # path                = var.health_check_path
#     interval            = 30
#   }
}

#redirecting all incomming traffic from ALB to the target group

resource "aws_lb_listener" "tech_nginx_listener" {
  load_balancer_arn = aws_lb.tech_nginx_app_alb.arn
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tech_nginx_app_tg.arn
  }
}

# Create ALB target group attachment
resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.tech_nginx_app_tg.arn
  target_id        = aws_instance.tech_nginx_web.id
  port             = 80

#   tags {
#     Name = "lb-target-group-attachment"
#   }
}