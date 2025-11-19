provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "test" {
    ami = "ami-0d176f79571d18a8f"
    instance_type = "t3.micro"
    tags = {
      Name = "anand"
    }
}
