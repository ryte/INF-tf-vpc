output "ids" {
  value       = aws_subnet.subnet.*.id
  description = "Subnet IDs."
}

output "route_table_id" {
  value       = aws_route_table.subnet.id
  description = "ID of the routing table associated with this subnets."
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.gw[0].id
  description = "ID of the NAT gateway deployed in one of the subnets."
}

output "nat_gateway_public_ip" {
  value       = aws_eip.eip.*.public_ip
  description = "IP of the NAT gateway deployed in one of the subnets."
}

output "nat_gateway_fqdn" {
  value       = aws_route53_record.record.fqdn
  description = "FQDN of the NAT GW"
}
