output "egw_id" {
  value       = aws_egress_only_internet_gateway.egw.id
  description = "ID of the Egress only gateway deployed along with the VPC."
}

output "id" {
  value       = aws_vpc.vpc.id
  description = "VPC id created."
}

output "igw_id" {
  value       = aws_internet_gateway.igw.id
  description = "igw id"
}
