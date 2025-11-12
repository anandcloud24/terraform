# resource "aws_instance" "name" {
#     ami = "ami-0cae6d6fe6048ca2c"
#     instance_type = "t2.micro"
#     count = 2
#     # tags = {
#     #   Name = "dev"
#     # }
#     # creating two instance with same name
#   tags = {
#       Name = "dev-${count.index}"# count.index it will be assining the each server name and labled the numbers
#     }
# }

variable "env" {
    type = list(string)
    default = [ "prod","test"]#if we remove the one of the  2nd server name it will be remove the 3rd server and assing same name
  }
  resource "aws_instance" "name" {
    ami = "ami-0cae6d6fe6048ca2c"
    instance_type = "t2.micro"
    count = length(var.env)
    # tags = {
    #   Name = "dev"
    # }
  tags = {
      Name = var.env[count.index]
    }
}

