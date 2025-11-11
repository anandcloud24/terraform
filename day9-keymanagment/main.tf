provider "aws" {
  region = "ap-south-1"
}
# Key Pair
resource "aws_key_pair" "example" {
  key_name   = "test"
  public_key = file("~/.ssh/id_ed25519")
}

#instance
resource "aws_instance" "server" {
  ami                         = "ami-06dd5c911c0d8dcdc" # amazon AMI
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.example.key_name
  
}