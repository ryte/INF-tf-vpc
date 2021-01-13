# INF-tf-vpc

Terraform module for creating a vpc

there is a EGW and a IGW deployed along with the VPC and flowlogs are beeing setup

also a available in that module
- [public subnet](subnet/public/README.md)
- [private subnet](subnet/private/README.md)


This project is [internal open source](https://en.wikipedia.org/wiki/Inner_source)
and currently maintained by the [INF](https://github.com/orgs/ryte/teams/inf).


## Module Input Variables

- `availability_zones`
    -  __description__: Region AZs this VPC should cover. Currently this would be a list of two (a, b) or three (a, b, c) AZs.
    -  __type__: `map`
    -  __default__: ["a", "b", "c"]

- `cidr_v4`
    -  __description__: VPC CIDR
    -  __type__: `string`
    -  __default__: "10.0.0.0/16"

- `deploy_flowlogs`
    -  __description__: Deploy or not deploy VPC flowlogs in CloudWatch Logs
    -  __type__: `string`
    -  __default__: true

- `domain_internal`
    -  __description__: Set this to an internal domain name to be associated with the VPC.
    -  __type__: `string`
    -  __default__: ""

- `environment`
    -  __description__: the environment this vpc is created in (e.g. 'testing')
    -  __type__: `string`

- `flowlogs_retention_in_days`
    -  __description__: CloudWatch Logs entry retention in days
    -  __type__: `string`
    -  __default__: 90

- `flowlogs_traffic_type`
    -  __description__: The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL
    -  __type__: `string`
    -  __default__: "REJECT"

- `tags`
    -  __description__: a map of tags which is added to all supporting ressources
    -  __type__: `map`
    -  __default__: {}

## Usage

```hcl
module "vpc" {
  tags                       = local.common_tags
  environment                = var.environment
  cidr_v4                    = var.cidr_v4
  flowlogs_retention_in_days = 5

  source = "github.com/ryte/INF-tf-vpc?ref=v0.3.1"
}
```

## Outputs

- `egw_id`
    -  __description__: ID of the Egress only gateway deployed along with the VPC
    -  __type__: `string`

- `id`
    -  __description__: VPC id created
    -  __type__: `string`

- `igw_id`
    -  __description__: ID of the Internet Gateway deployed along with the VPC
    -  __type__: `string`


## Authors

- [Armin Grodon](https://github.com/x4121)
- [Markus Schmid](https://github.com/h0raz)

## Changelog

- 0.3.1 - Add variable `environment` instead of reading from tags
- 0.3.0 - Upgrade to terraform 0.12.x
- 0.2.0 - made the Route53 zone a variable instead of data lookup
- 0.1.1 - replace egress only gateway with gateway in public subnet
- 0.1.0 - Initial release.

## License

This software is released under the MIT License (see `LICENSE`).
