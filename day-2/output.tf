output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.name.id
}

output "subnet_id" {
  description = "The ID of the created Subnet"
  value       = aws_subnet.name.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.name.id
}
