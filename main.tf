data "aws_region" "current" {
}

resource "aws_vpc" "vpc" {
  lifecycle {
    create_before_destroy = true
  }

  assign_generated_ipv6_cidr_block = true
  cidr_block                       = var.cidr_v4
  enable_dns_hostnames             = true
  enable_dns_support               = true
  tags                             = local.tags
}

data "aws_route53_zone" "private_zone" {
  count        = length(var.domain_internal) > 0 ? 1 : 0
  name         = "${var.domain_internal}."
  private_zone = true
}

resource "aws_route53_zone_association" "private_zone" {
  count   = length(var.domain_internal) > 0 ? 1 : 0
  zone_id = data.aws_route53_zone.private_zone[0].zone_id
  vpc_id  = aws_vpc.vpc.id
}

resource "aws_egress_only_internet_gateway" "egw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_internet_gateway" "igw" {
  tags   = local.tags
  vpc_id = aws_vpc.vpc.id
}

resource "aws_vpc_dhcp_options" "vpc" {
  count               = length(var.domain_internal) > 0 ? 1 : 0
  domain_name         = var.domain_internal
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name = "${terraform.workspace}-dhcp-option-set"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  count           = length(var.domain_internal) > 0 ? 1 : 0
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.vpc[0].id
}

