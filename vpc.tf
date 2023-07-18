resource "aws_vpc" "tech_nginx_app" {
  cidr_block          = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "tech_nginx_app"
  }
}

resource "aws_internet_gateway" "tech_nginx_ig" {
  vpc_id = aws_vpc.tech_nginx_app.id
}



resource "aws_subnet" "tech_nginx_pub_sn1" {
  vpc_id            = aws_vpc.tech_nginx_app.id
  cidr_block        = var.tech_nginx_pub_sn1_cidr
  availability_zone = var.availability_zone[0]



  tags = {
    Name = "tech_nginx_pub_sn" #var.tech_nginx_pub_sn[count.index]
  }
}

resource "aws_subnet" "tech_nginx_pub_sn2" {
  vpc_id            = aws_vpc.tech_nginx_app.id
  cidr_block        = var.tech_nginx_pub_sn2_cidr
  availability_zone = var.availability_zone[1]



  tags = {
    Name = "tech_nginx_pub_sn" #var.tech_nginx_pub_sn[count.index]
  }
}

# resource "aws_subnets" "tech_nginx_priv_sn" {
#   vpc_id            = aws_vpc.tech_nginx_app.id
#   cidr_block        = var.tech_nginx_priv_sn_cidr
#   availability_zone = availability_zones.available_zone[0]

#   tags = {
#     Name = "tech_nginx_priv_sn"
#   }
# }

resource "aws_route_table" "tech_nginx_rt" {
  vpc_id = aws_vpc.tech_nginx_app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tech_nginx_ig.id
  }
}

resource "aws_route_table_association" "pub_sn1" {
  subnet_id      = aws_subnet.tech_nginx_pub_sn1.id
  route_table_id = aws_route_table.tech_nginx_rt.id
}

resource "aws_route_table_association" "pub2_sn" {
  subnet_id      = aws_subnet.tech_nginx_pub_sn2.id
  route_table_id = aws_route_table.tech_nginx_rt.id
}