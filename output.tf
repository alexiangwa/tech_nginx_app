

output "vpc_id" {
  value = aws_vpc.tech_nginx_app.id
}
output "tech_nginx_app_alb" {
  value = aws_lb.tech_nginx_app_alb.arn
}

output "tech_nginx_app_tg"{
  value = aws_lb_target_group.tech_nginx_app_tg.arn
}