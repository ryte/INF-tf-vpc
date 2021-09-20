# INF-tf-vpc public subnet

Terraform module for creating public subnets in multiple availability zones

if ngw is set to true a nat gateway with a elastic IP is setup

This project is [internal open source](https://en.wikipedia.org/wiki/Inner_source)
and currently maintained by the [INF](https://github.com/orgs/ryte/teams/inf).


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

The following requirements are needed by this module:

- terraform (>= 0.12)

## Providers

The following providers are used by this module:

- aws

## Required Inputs

The following input variables are required:

### domain

Description: the module creates a route53 domain entry and therefore need the domain in which the entry should be created

Type: `string`

### egw\_id

Description: ID of the Egress only gateway for outgoing IPV6 traffic.

Type: `string`

### environment

Description: the environment this vpc is created in (e.g. 'testing')

Type: `string`

### igw\_id

Description: ID of the Internet gateway for outgoing. IPV4 traffic.

Type: `string`

### vpc\_id

Description: VPC id the subnets will be defined in

Type: `string`

### zone\_id

Description: route53 zone id needed for nat gateway

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### availability\_zones

Description: Region AZs this VPC should cover. Currently this would be a list of two (a, b) or three (a, b, c) AZs.

Type: `list(string)`

Default:

```json
[
  "a",
  "b",
  "c"
]
```

### ngw

Description: Deploy a NAT gateway inside the created subnets.

Type: `bool`

Default: `false`

### ngw\_az

Description: Defines in which AZ the NAT gateway will be deployed in. Depends on `ngw=true`.

Type: `string`

Default: `"a"`

### ngw\_hostname

Description: n/a

Type: `string`

Default: `"natgw"`

### tags

Description: common tags to add to the ressources

Type: `map(string)`

Default: `{}`

### v4\_netnum\_summand

Description: subnet count offset

Type: `any`

Default: `null`

### v4\_newbits

Description: bits for the new subnets 8 creates a /24 from a /16 VPC

Type: `number`

Default: `8`

### v6\_netnum\_summand

Description: subnet count offset

Type: `any`

Default: `null`

### v6\_newbits

Description: bits for the new subnets 8 creates a /24 from a /16 VPC

Type: `number`

Default: `8`

## Outputs

The following outputs are exported:

### ids

Description: List of subnet IDs.

### nat\_gateway\_fqdn

Description: FQDN of the NAT GW

### nat\_gateway\_id

Description: ID of the NAT gateway deployed in one of the subnets.

### nat\_gateway\_public\_ip

Description: IP of the NAT gateway deployed in one of the subnets.

### route\_table\_id

Description: ID of the routing table associated with this subnets.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

```hcl
module "subnet_private" {
  tags        = local.common_tags
  environment = var.environment

  // disable egw (IPv6) gateway for IPv4 whitelisting
  // egw_id      = module.vpc.egw_id
  gw          = "ngw"
  ngw_id      = module.subnet_public.nat_gateway_id
  zone_id     = aws_route53_zone.ryte_tech.id

  v4_newbits        = 3
  v4_netnum_summand = 3
  v6_netnum_summand = 3

  // availability_zones = ["a", "b", "c"]
  vpc_id = module.vpc.id

  source = "github.com/ryte/INF-tf-vpc//subnet/private?ref=v0.3.1"
}
```
