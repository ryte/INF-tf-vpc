# INF-tf-vpc public subnet

Terraform module for creating public subnets in multiple availability zones

if ngw is set to true a nat gateway with a elastic IP is setup

This project is [internal open source](https://en.wikipedia.org/wiki/Inner_source)
and currently maintained by the [INF](https://github.com/orgs/ryte/teams/inf).


## Module Input Variables


- `availability_zones`
    -  __description__: Region AZs this VPC should cover. Currently this would be a list of two (a, b) or three (a, b, c) AZs.
    -  __type__: `map`
    -  __default__: ["a", "b", "c"]

- `domain`
    -  __description__: the module creates a route53 domain entry and therefore need the domain in which the entry should be created
    -  __type__: `string`

- `egw_id`
    -  __description__: ID of the Egress only gateway for outgoing IPV6 traffic
    -  __type__: `string`
    -  __default__: ""

- `igw_id`
    -  __description__: ID of the Internet gateway for outgoing. IPV4 traffic
    -  __type__: `string`

- `ngw`
    -  __description__: Deploy a NAT gateway inside the created subnets
    -  __type__: `string`
    -  __default__: false

- `ngw_az`
    -  __description__: Defines in which AZ the NAT gateway will be deployed in. Depends on `ngw=true`
    -  __type__: `string`
    -  __default__: "a"

- `ngw_hostname`
    -  __description__:
    -  __type__: `string`
    -  __default__: "natgw"

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

- `zone_id`
    -  __description__: route53 zone id needed for nat gateway
    -  __type__: `string`


## Usage

```hcl
module "subnet_private" {
  tags        = local.common_tags

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

  source = "github.com/ryte/INF-tf-vpc.git?ref=v0.3.0//subnet/private"
}
```

## Outputs

- `ids`
    -  __description__: List of subnet ids
    -  __type__: `list`

 - `nat_gateway_fqdn`
    -  __description__: FQDN of the NAT GW
    -  __type__: `string`

 - `nat_gateway_id`
    -  __description__: ID of the NAT gateway deployed in one of the subnets
    -  __type__: `string`

 - `nat_gateway_public_ip`
    -  __description__: IP of the NAT gateway deployed in one of the subnets
    -  __type__: `string`

 - `route_table_id`
    -  __description__: ID of the routing table associated with this subnets
    -  __type__: `string`
