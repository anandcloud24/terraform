resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/18"
    tags = {
      name ="anand_vpc"
    }
  
}
resource "aws_subnet" "test" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    tags = {
        name = "public_subnet"

    }  
}
resource "aws_subnet" "dev" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
        name = "private-subnet"

    }  
}
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      name = "ig"
    }
  
}
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      name = "rt"
    }
      
      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
      }
}
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.dev.id
    route_table_id = aws_route_table.name.id
}
resource "aws_security_group" "name" {
    name = "allow"
    vpc_id = aws_vpc.name.id
    tags = {
      name = "sg"
    }
    ingress {
        description = "http"
        from_port = 80
        to_port = 100
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        description = "HTTPs"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }  
     egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }  
    
}
resource "aws_eip" "nat_eip" {
   domain = "vpc"
   tags = {
     Name = "nat-eip"
   }

}
resource "aws_nat_gateway" "name" { 

  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.test.id

  tags = {
    Name = "gw NAT"
  }
  depends_on = [aws_internet_gateway.name]
}
resource "aws_route_table" "rt-2" {
    vpc_id = aws_vpc.name.id
    route  {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.name.id
    }
    tags = {
      name = "private-rt"
    }
}
resource "aws_route_table_association" "nat" {
    subnet_id = aws_subnet.dev.id
    route_table_id = aws_route_table.rt-2.id
  
}
resource "aws_instance" "name" {
    ami = "ami-0bdd88bd06d16ba03"
    instance_type = "t3.micro"
    region = "us-east-1"
    subnet_id = aws_subnet.test.id
    tags = {
        name = "anand"
    }
  
}
resource "aws_instance" "name2" {
    ami = "ami-0bdd88bd06d16ba03"
    instance_type = "t2.micro"
    region = "us-east-1"
    subnet_id = aws_subnet.dev.id
    tags = {
        name = "anand2"
    }
}        