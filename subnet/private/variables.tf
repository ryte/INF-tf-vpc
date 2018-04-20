variable "cid" {}
variable "environment" {}
variable "name" {}
variable "owner" {}
variable "project" {}

variable "vpc_id" {
  description = "VPC id the subnets will be defined in."
}

variable "availability_zones" {
  default     = ["a", "b", "c"]
  type        = "list"
  description = "List of AZs the subnet will be created in."
}

variable "egw_id" {
  default     = ""
  description = "Reference to an Egress only gateway for outgoing IPV6 traffic. If defined appropriate routing will be defined in the subnet routing table. depends on variable gw"
}

variable "ngw_id" {
  default     = ""
  description = "Reference to an NAT gateway for outgoing IPV4 traffic. If defined appropriate routing will be defined in the subnet routing table. depends on variable gw"
}

variable "v4_newbits" {
  default = 8 // /24 with 10.0.0.0/16
}

variable "v6_newbits" {
  default = 8 // /64
}

variable "v4_netnum_summand" {}
variable "v6_netnum_summand" {}

variable "gw" {
  default     = false
  description = "set the gateway, 'ngw', 'egw', false allowed"
}