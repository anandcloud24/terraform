resource "aws_instance" "name" {
    ami = "ami-01a612f2c60d80101"
    region = "eu-central-1"
    instance_type = "t3.micro"
    tags = {
      Name = "tesing"
    }

  }
#terraform import aws_instance.name i-094c702f6ef80b351
# the import will be manual creating instance in aws and as is of amiid,region,instance_type,tags 
#give the information created instance data in vs code in top command to run in vs code <in the command place instance id>