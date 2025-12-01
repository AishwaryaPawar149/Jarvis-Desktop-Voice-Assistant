provider "aws" {
  region = "ap-south-1"
}

data "aws_security_group" "jarvis_sg" {
  filter {
    name   = "group-name"
    values = ["jarvis-sg"]
  }

  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_instance" "jarvis" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = var.keypair
  subnet_id     = var.public_subnet
  vpc_security_group_ids = [data.aws_security_group.jarvis_sg.id]

  associate_public_ip_address = true   # ✅ add this line
  user_data = file("userdata.sh")

  tags = {
    Name = "Jarvis-Voice-Assistant"
  }
}
