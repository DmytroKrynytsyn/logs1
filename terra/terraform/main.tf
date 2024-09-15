provider "aws" {
  region = var.aws_region  
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "fluentd"
    from_port   = 18080
    to_port     = 18080
    protocol    = "tcp"
    self        = true
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "logs"
    Purpose = "dkedu"
    Stack = "logs1"
  }
}

resource "aws_instance" "fluentd" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.web_sg.name]

  key_name = "cks"

  tags = {
    Name = "fluentd"
    Role = "fluentd"
    Purpose = "dkedu"
    Stack = "logs1"
  }
}

resource "aws_instance" "kibana" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.web_sg.name]

  key_name = "cks"

  tags = {
    Name = "kibana"
    Role = "kibana"
    Purpose = "dkedu"
    Stack = "logs1"
  }
}

resource "aws_instance" "elasticsearch" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.web_sg.name]

  key_name = "cks"

  tags = {
    Name = "elasticsearch"
    Role = "elasticsearch"
    Purpose = "dkedu"
    Stack = "logs1"
  }
}

resource "aws_instance" "node" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.web_sg.name]

  key_name = "cks"

  tags = {
    Name = "node"
    Role = "node"
    Purpose = "dkedu"
    Stack = "logs1"
  }
}