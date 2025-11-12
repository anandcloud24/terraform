resource "aws_security_group" "anand" {
  name        = "anand"
  description = "Allow"

  ingress = [#it will creating sg with same cider to multiple port ranges to create multiple sgs
    
    for port in [22, 80, 443, 8080, 9000, 3000, 8082, 8081, 3306] : {
      description      = "inbound rules"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "anand"
  }
}