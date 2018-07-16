/*data "aws_internet_gateway" "igw" {
  filter {
    name   = "attachment.vpc-id"
    values = ["${var.vpc_id}"]
  }
}*/

data "aws_region" "current" {}

data "aws_vpc" "current" {
  id = "${var.vpc_id}"
}

resource "aws_route_table_association" "subnet" {
  count = "${length(var.availability_zones)}"

  route_table_id = "${aws_route_table.subnet.id}"
  subnet_id      = "${aws_subnet.subnet.*.id[count.index]}"
}

resource "aws_route_table" "subnet" {
  // propagating_vgws = "${var.vgws}"
  tags   = "${local.tags}"
  vpc_id = "${var.vpc_id}"
}

resource "aws_route" "public_default" {
  route_table_id         = "${aws_route_table.subnet.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${var.igw_id}"
}

resource "aws_route" "public_default6" {
  route_table_id              = "${aws_route_table.subnet.id}"
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = "${var.igw_id}"
}

resource "aws_subnet" "subnet" {
  count = "${length(var.availability_zones)}"

  assign_ipv6_address_on_creation = true
  availability_zone               = "${data.aws_region.current.name}${var.availability_zones[count.index]}"
  cidr_block                      = "${cidrsubnet(data.aws_vpc.current.cidr_block, var.v4_newbits, var.v4_netnum_summand + count.index)}"
  ipv6_cidr_block                 = "${cidrsubnet(data.aws_vpc.current.ipv6_cidr_block, var.v6_newbits, var.v6_netnum_summand + count.index)}"
  map_public_ip_on_launch         = true
  tags                            = "${merge(local.tags)}"
  vpc_id                          = "${var.vpc_id}"
}
