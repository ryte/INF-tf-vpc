# INF-tf-vpc private subnet

Terraform module for creating private subnets in multiple availability zones

if gw is set to "egw" a `egw_id` must be given and a routing for the egw IPv6 is set up

if gw is set to "ngw" a `ngw_id` must be given and a routing for the egw IPv4 is set up


This project is [internal open source](https://en.wikipedia.org/wiki/Inner_source)
and currently maintained by the [INF](https://github.com/orgs/onpage-org/teams/inf).


## Module Input Variables

- `availability_zones`
    -  __description__: Region AZs this VPC should cover. Currently this would be a list of two (a, b) or three (a, b, c) AZs.
    -  __type__: `map`
    -  __default__: ["a", "b", "c"]

- `egw_id`
    -  __description__: Reference to an Egress only gateway for outgoing IPV6 traffic. If defined appropriate routing will be defined in the subnet routing table. depends on variable gw
    -  __type__: `string`
    -  __default__: ""

- `gw`
    -  __description__: set the gateway, values 'ngw', 'egw', false are allowed
    -  __type__: `string`
    -  __default__: false

- `ngw_id`
    -  __description__: Reference to an NAT gateway for outgoing IPV4 traffic. If defined appropriate routing will be defined in the subnet routing table. depends on variable gw
    -  __type__: `string`
    -  __default__:

- `tags`
    -  __description__: a map of tags which is added to all supporting ressources
    -  __type__: `map` `string`
    -  __default__: {}

- `v4_netnum_summand`
    -  __description__: subnet count offset
    -  __type__: `string`
    -  __default__:

- `v4_newbits`
    -  __description__: bits for the new subnets 8 creates a /24 from a /16 VPC
    -  __type__: `string`
    -  __default__: 8

- `v6_netnum_summand`
    -  __description__: subnet count offset
    -  __type__: `string`
    -  __default__:

- `v6_newbits`
    -  __description__: bits for the new subnets 8 creates a /24 from a /16 VPC
    -  __type__: `string`
    -  __default__: 8

- `vpc_id`
    -  __description__: VPC id the subnets will be defined in
    -  __type__: `string`


## Usage

```hcl
module "subnet_private" {
  tags        = "${local.common_tags}"

  // disable egw (IPv6) gateway for IPv4 whitelisting
  // egw_id      = "${module.vpc.egw_id}"
  gw          = "ngw"
  ngw_id      = "${module.subnet_public.nat_gateway_id}"

  v4_newbits        = 3
  v4_netnum_summand = 3
  v6_netnum_summand = 3

  // availability_zones = ["a", "b", "c"]
  vpc_id = "${module.vpc.id}"

  source = "git@github.com:onpage-org/INF-tf-vpc.git?ref=v0.1.0//subnet/private"
}
```

## Outputs

- `arns`
    -  __description__: List of subnet arns
    -  __type__: `list`

- `ids`
    -  __description__: List of subnet ids
    -  __type__: `list`