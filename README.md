# INF-tf-vpc

Terraform module for creating a vpc

there is a EGW and a IGW deployed along with the VPC and flowlogs are beeing setup

also a available in that module
- [public subnet](subnet/public/README.md)
- [private subnet](subnet/private/README.md)


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

## Optional Inputs

The following input variables are optional (have default values):

### availability\_zones

Description: Region AZs this VPC should cover. Currently this would be a list of two (a, b) or three (a, b, c) AZs.

Type: `list`

Default:

```json
[
  "a",
  "b",
  "c"
]
```

### cidr\_v4

Description: VPC CIDR.

Type: `string`

Default: `"10.0.0.0/16"`

### deploy\_flowlogs

Description: Deploy or not deploy VPC flowlogs in CloudWatch Logs.

Type: `bool`

Default: `true`

### domain\_internal

Description: Set this to an internal domain name to be associated with the VPC.

Type: `string`

Default: `""`

### flowlogs\_retention\_in\_days

Description: CloudWatch Logs entry retention in days.

Type: `number`

Default: `90`

### flowlogs\_traffic\_type

Description: The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL

Type: `string`

Default: `"REJECT"`

### tags

Description: common tags to add to the ressources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### egw\_id

Description: ID of the Egress only gateway deployed along with the VPC.

### id

Description: VPC id created.

### igw\_id

Description: ID of the Internet Gateway deployed along with the VPC

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
