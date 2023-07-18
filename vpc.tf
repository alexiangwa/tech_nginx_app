
resource "aws_vpc" "tech_nginx_app" {
  cider_block          = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "tech_nginx_app"
  }
}

resource "aws_internet_gateway" "tech_nginx_ig" {
  vpc_id = aws_vpc.tech_nginx_app.id
}

data "availability_zones" "available_zone" {
  # state = "available"
}

resource "aws_subnets" "tech_nginx_pub_sn" {
  vpc_id            = aws_vpc.tech_nginx_app.id
  cidr_block        =var.tech_nginx_pub_sn_cidr
  availability_zone = data.availability_zones.available_zone.names[0][1]



  tags = {
    Name = "tech_nginx_pub_sn" #var.tech_nginx_pub_sn[count.index]
  }
}

resource "aws_subnets" "tech_nginx_priv_sn" {
  vpc_id            = aws_vpc.tech_nginx_app.id
  cidr_block        = var.tech_nginx_priv_sn_cidr
  availability_zone = data.availability_zones.available_zone.names[0][1]

  tags = {
    Name = "tech_nginx_priv_sn"
  }
}

resource "aws_route_table" "tech_nginx_rt" {
  vpc_id = aws_vpc.tech_nginx_app.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tech_nginx_ig.id
  }
}

resource "aws_route_table_association" "name" {
  subnet_id      = aws_subnets.tech_nginx_pub_sn.id
  route_table_id = aws_route_table.tech_nginx_rt.id
}