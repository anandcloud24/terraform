resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/18"
    tags = {
      name = "anand"
    }
  
}