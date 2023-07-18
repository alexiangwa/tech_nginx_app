#!/bin/bash
    sudo yum update -y
    sudo yum install -y nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
    sudo echo "<h1> WELCOME TEAM </h1>" >> | sudo tee /var/www/html/index.html
    sudo mkdir /var/www/html/app1