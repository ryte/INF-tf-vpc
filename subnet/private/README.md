# INF-tf-vpc private subnet

Terraform module for creating private subnets in multiple availability zones

if gw is set to "egw" a `egw_id` must be given and a routing for the egw IPv6 is set up

if gw is set to "ngw" a `ngw_id` must be given and a routing for the egw IPv4 is set up


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

### environment

Description: the environment this vpc is created in (e.g. 'testing')

Type: `string`

### vpc\_id

Description: VPC id the subnets will be defined in.

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

### egw\_id

Description: Reference to an Egress only gateway for outgoing IPV6 traffic. If defined appropriate routing will be defined in the subnet routing table. depends on variable gw

Type: `string`

Default: `""`

### gw

Description: set the gateway, 'ngw', 'egw', false allowed

Type: `bool`

Default: `false`

### ngw\_id

Description: Reference to an NAT gateway for outgoing IPV4 traffic. If defined appropriate routing will be defined in the subnet routing table. depends on variable gw

Type: `string`

Default: `""`

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

Description: List of subnet ids

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

  v4_newbits        = 3
  v4_netnum_summand = 3
  v6_netnum_summand = 3

  // availability_zones = ["a", "b", "c"]
  vpc_id = module.vpc.id

  source = "github.com/ryte/INF-tf-vpc//subnet/private?ref=v0.3.1"
}
```
