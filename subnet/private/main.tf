data "aws_region" "current" {
}

data "aws_vpc" "current" {
  id = var.vpc_id
}

resource "aws_route_table" "global_route_table" {
  tags   = merge(local.tags, { Role = "global" })
  vpc_id = var.vpc_id
}

// Egress only gateway but no NAT

resource "aws_route" "subnet_egw_default6" {
  count = local.is_egw

  route_table_id              = aws_route_table.global_route_table.id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = var.egw_id
}

resource "aws_route_table_association" "subnet_egw" {
  count = local.is_egw * length(var.availability_zones)

  route_table_id = aws_route_table.global_route_table.id
  subnet_id      = aws_subnet.subnet[count.index].id
}

// NAT gateway defined

resource "aws_route" "subnet_ngw_default" {
  count = local.is_ngw

  route_table_id         = aws_route_table.global_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.ngw_id
  depends_on             = [aws_route_table.global_route_table]
}

resource "aws_route_table_association" "subnet_ngw" {
  count = local.is_ngw * length(var.availability_zones)

  route_table_id = aws_route_table.global_route_table.id
  subnet_id      = aws_subnet.subnet[count.index].id
}

// Subnets

resource "aws_subnet" "subnet" {
  count = length(var.availability_zones)

  assign_ipv6_address_on_creation = true
  availability_zone               = "${data.aws_region.current.name}${var.availability_zones[count.index]}"
  cidr_block = cidrsubnet(
    data.aws_vpc.current.cidr_block,
    var.v4_newbits,
    var.v4_netnum_summand + count.index,
  )
  ipv6_cidr_block = cidrsubnet(
    data.aws_vpc.current.ipv6_cidr_block,
    var.v6_newbits,
    var.v6_netnum_summand + count.index,
  )
  map_public_ip_on_launch = false
  tags                    = local.tags
  vpc_id                  = var.vpc_id
}
