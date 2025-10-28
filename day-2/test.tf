resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_terr"
  }
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.0.0/24"
    tags = {
    Name = "subnet1"
    }
}
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.vpc.id
     tags = {
       Name = "ig anand"
     }

  
}