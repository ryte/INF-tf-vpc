output "ids" {
  description = "List of subnet ids"
  value       = aws_subnet.subnet.*.id
}
