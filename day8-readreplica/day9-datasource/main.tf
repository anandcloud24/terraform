data "aws_subnet" "name" {
  filter {
    name   = "tag:Name"
    values = ["public subnet 1"]
  }
}

data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "prod" {
  ami           = data.aws_ami.amzlinux.id
  instance_type = "t3.micro"
  subnet_id     = data.aws_subnet.name.id
   associate_public_ip_address = true
  tags = {
    Name = "prod-instance"
    Env  = "test"
  }
}

output "instance_id" {
  value = aws_instance.prod.id
}
output "instance_public_ip" {
  value = aws_instance.prod.public_ip
}

# data "aws_ami" "amzlinux" {
#   most_recent = true
#   owners = [ "self" ]
#   filter {
#     name = "name"
#     values = [ "frontend-ami" ]
#   }

# }




#use of this code is to use existing resource like ami,spcific subnet ,using this resources to create instance from terraform