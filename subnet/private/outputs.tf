output "arns" {
  value = "${aws_subnet.subnet.*.arn}"
}

output "ids" {
  value = "${aws_subnet.subnet.*.id}"
}
