variable "tags" {
  description = "common tags to add to the ressources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "VPC id the subnets will be defined in."
  type        = string
}

variable "availability_zones" {
  description = "Region AZs this VPC should cover. Currently this would be a list of two (a, b) or three (a, b, c) AZs."
  type        = list(string)
  default     = ["a", "b", "c"]
}

variable "egw_id" {
  description = "Reference to an Egress only gateway for outgoing IPV6 traffic. If defined appropriate routing will be defined in the subnet routing table. depends on variable gw"
  default     = ""
}

variable "ngw_id" {
  description = "Reference to an NAT gateway for outgoing IPV4 traffic. If defined appropriate routing will be defined in the subnet routing table. depends on variable gw"
  default     = ""
}

variable "v4_newbits" {
  description = "bits for the new subnets 8 creates a /24 from a /16 VPC"
  default     = 8 // /24 with 10.0.0.0/16
}

variable "v6_newbits" {
  description = "bits for the new subnets 8 creates a /24 from a /16 VPC"
  default     = 8 // /64
}

variable "v4_netnum_summand" {
  description = "subnet count offset"
  default     = null
}

variable "v6_netnum_summand" {
  description = "subnet count offset"
  default     = null
}

variable "gw" {
  description = "set the gateway, 'ngw', 'egw', false allowed"
  default     = false
}

variable "environment" {
  description = "the environment this vpc is created in (e.g. 'testing')"
  type        = string
}
