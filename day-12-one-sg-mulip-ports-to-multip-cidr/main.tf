variable "allowed_ports" {
  type = map(string)#the map string it in port to cidr. string in will as the port in cidr will be assining ports to cidr block 
  default = {
    22    = "203.0.113.0/24"    # SSH (Restrict to office IP)
    80    = "0.0.0.0/0"         # HTTP (Public)
    443   = "0.0.0.0/0"         # HTTPS (Public)
    8080  = "10.0.0.0/16"       # Internal App (Restrict to VPC)
    9000  = "192.168.1.0/24"    # SonarQube/Jenkins (Restrict to VPN)
    3389  = "10.0.1.0/24"       # Remote Desktop Protocol(RDP)
  }
}

resource "aws_security_group" "name" {
  name        = "test"
  description = "Allow restricted inbound traffic"

  dynamic "ingress" {# ingress it is a inbound rule
    for_each = var.allowed_ports
    content {
      description = "Allow${ingress.key}"
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
     
  }

  egress {# egress it is a out bound rule
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "test"
  }
}

# Output the Security Group ID
output "security_group_id" {
  description = "The ID of the created security group"
  value       = aws_security_group.name
}