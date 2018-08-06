resource "aws_eip" "eip" {
  count = "${local.is_ngw}"

  vpc = true
}

locals {
  az_index        = ["a", "b", "c", "d", "e"]
  az_subnet_index = "${index(local.az_index, var.ngw_az)}"
}

resource "aws_nat_gateway" "gw" {
  count = "${local.is_ngw}"

  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${aws_subnet.subnet.*.id[local.az_subnet_index]}"
  tags          = "${merge(local.tags, map("AZ", "${data.aws_region.current.name}${var.ngw_az}"))}"
}


resource "aws_route53_record" "record" {
  name = "${var.ngw_hostname}.${var.domain}."

  records = [
    "${aws_eip.eip.public_ip}",
  ]

  ttl     = "60"
  type    = "A"
  zone_id = "${var.zone_id}"
}
