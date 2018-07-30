variable "tags" {
  type = "map"
  description = "common tags to add to the ressources"
  default = {}
}

variable "vpc_id" {}
variable "domain" {}

variable "availability_zones" {
  default     = ["a", "b", "c"]
  type        = "list"
  description = "List of AZs the subnet will be created in."
}

variable "ngw" {
  default     = false
  description = "Deploy a NAT gateway inside the created subnets."
}

variable "ngw_hostname" {
  default = "natgw"
}

variable "ngw_az" {
  default     = "a"
  description = "Defines in which AZ the NAT gateway will be deployed in. Depends on `ngw=true`."
}

variable "egw_id" {
  description = "ID of the Egress only gateway for outgoing IPV6 traffic."
}

variable "igw_id" {
  description = "ID of the Internet gateway for outgoing. IPV4 traffic."
}

variable "v4_newbits" {
  default = 8 // /24 with 10.0.0.0/16
}

variable "v6_newbits" {
  default = 8 // /64
}

variable "v4_netnum_summand" {}
variable "v6_netnum_summand" {}

// variable "vgws" {
//   type    = "list"
//   default = []
// }


variable "zone_id" {
  type = "string"
}