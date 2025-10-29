resource "aws_instance" "name" {
  ami           = "ami-07860a2d7eb515d9a"  
  instance_type = "t3.micro"
  key_name      = "anandkeypair"
  subnet_id = "subnet-067ea8b566ae256be"

  tags = {
    Name = "anand"  
  }
}
