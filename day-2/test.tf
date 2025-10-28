resource "aws_vpc" "name" {
  cidr_block = var.vpc
    tags = {
    Name = "vpc_ab"
  }
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet
    tags = {
    Name = "subnet-er"
    }
}
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
     tags = {
       Name = "ig test"
     }

  
}