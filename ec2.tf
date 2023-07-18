resource "aws_instance" "tech_nginx_web" {
    ami = data.aws_ami.amzlinux2.id
   # ami = "ami-06ca3ca175f37dd66"
    #availability_zone = "us-east-1a"
    instance_type = var.instance_type
    key_name = var.keypair
    user_data = file("${path.module}/nginx.sh")
    subnet_id = aws_subnets.tech_nginx_pub_sn.id
    vpc_security_group_ids = [aws_security_group.tech_nginx_vpc_ssh.id]
    associate_public_ip_address = true	
    tags = {
        Name = "tech_nginx-app"
        Env = "DEV"
        
    }
}
