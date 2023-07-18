# create a security group - SSH traffic
# aws_security_group.vpc_ssh.id
resource "aws_security_group" "tech_nginx_vpc_ssh" {
  name        = "tech_nginx_vpc_ssh"
  description = "Dev vpc ssh"
   vpc_id      = aws_vpc.tech_nginx_app.id

  ingress {
    description      = "allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      ="allow all ip and ports outbounds"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tech_nginx_vpc_ssh"
  }
}

# create security group for Web Traffic

# aws_security_group.vpc_web.id  #(resource name.local name.id)
resource "aws_security_group" "tech_nginx_app_vpc_web" {
  name        = "tech_nginx_app_vpc_web"
  description = "Dev vpc web"
  vpc_id      = aws_vpc.tech_nginx_app.id

  ingress {
    description      = "allow port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

 ingress {
    description      = "allow port 443"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      ="allow all ip and ports outbounds"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name ="tech_nginx_vpc_web"
}
}