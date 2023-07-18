#vpc  Input Variables


#VPC CIDR Block
variable "vpc_cidr_block" {
  description = "my vpc cidr block"
  type = string 
  default = "10.0.0.0/16"
}


#VPC private subnet
variable "tech_nginx_priv_sn_cidr" {
  description = " vpc private subnet"
  type = list(string)
  default = [ "10.0.3.0/24","10.0.4.0/24" ]
}

# VPC public subnets
variable "tech_nginx_pub_sn_cidr" {
  description = "vpc pulic subnets"
  type = list(string)
  default = [ "10.0.1.0/24","10.0.2.0/24" ]
}



# EC2 input variables
#AWS Region
variable "aws_region" {
  description = "aws region to be created"
  type = string
  default = "us-east-1"
}

# AWS EC2 Instance type
variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}

# AWS EC2 Instnace Key pair
variable "key_name" {
    description = "keypair that needs to be associated with EC2 instance"
    type = string
    default = "keypair"
}