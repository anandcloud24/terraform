resource "aws_db_instance" "anand" {
  allocated_storage       = 10
  db_name                 = "database"
  identifier              = "testing"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t2.micro"
  username                = "admin"
  password                = "Anand12345"
  db_subnet_group_name    = aws_db_subnet_group.sub_grp.id
  parameter_group_name    = "default.mysql8.0"

  # Enable backups and retention
  backup_retention_period  = 7   # Retain backups for 7 days
  backup_window            = "02:00-03:00" # Daily backup window (UTC)

  # Enable monitoring (CloudWatch Enhanced Monitoring)
  monitoring_interval      = 60  # Collect metrics every 60 seconds
  monitoring_role_arn      = aws_iam_role.rds_monitoring-5.arn


  # Maintenance window
  maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)

  # Enable deletion protection (to prevent accidental deletion)
  deletion_protection = false

  # Skip final snapshot
  skip_final_snapshot = false
}

# # IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring-5" {
  name = "rds-monitoring-5-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}

#IAM Policy Attachment for RDS Monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring-5_attach" {
  role       = aws_iam_role.rds_monitoring-5.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}





####### with data source ###########
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "testing"
    }
  
}
resource "aws_subnet" "subnet-a" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-southeast-1c"
  
}
resource "aws_subnet" "subnet-b" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-southeast-1a"
  
}
resource "aws_db_subnet_group" "sub_grp" {
  name       = "mysubnet"
  subnet_ids = [aws_subnet.subnet-a.id, aws_subnet.subnet-b.id]

  tags = {
    Name = "My DB subnet group"
  }
}
# --------------------------
# Create Read Replica of the Primary DB
# --------------------------
resource "aws_db_instance" "read_replica" {
  identifier            = "rds-test-replica"
  instance_class        = "db.t3.micro"
  publicly_accessible   = true
  replicate_source_db = aws_db_instance.anand.arn # ✅ link to primary DB
  db_subnet_group_name  = aws_db_subnet_group.sub_grp.name
  monitoring_interval   = 60
  monitoring_role_arn   = aws_iam_role.rds_monitoring-5.arn

  depends_on = [
    aws_db_instance.anand
  ]

  tags = {
    Name = "rds-read-replica"
    Role = "read-replica"
  }
}
