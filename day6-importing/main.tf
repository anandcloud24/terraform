resource "aws_instance" "name" {
    ami = "ami-01a612f2c60d80101"
    region = "eu-central-1"
    instance_type = "t3.micro"
    tags = {
      Name = "tesing"
    }

  }
