variable "tags" {
  description = "common tags to add to the ressources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "VPC id the subnets will be defined in"
  type        = string
}

variable "domain" {
  description = "the module creates a route53 domain entry and therefore need the domain in which the entry should be created"
  type        = string
}

variable "availability_zones" {
  description = "Region AZs this VPC should cover. Currently this would be a list of two (a, b) or three (a, b, c) AZs."
  type        = list(string)
  default     = ["a", "b", "c"]
}

variable "ngw" {
  description = "Deploy a NAT gateway inside the created subnets."
  default     = false
}

variable "ngw_hostname" {
  default = "natgw"
}

variable "ngw_az" {
  description = "Defines in which AZ the NAT gateway will be deployed in. Depends on `ngw=true`."
  default     = "a"
}

variable "egw_id" {
  description = "ID of the Egress only gateway for outgoing IPV6 traffic."
  type        = string
}

variable "igw_id" {
  description = "ID of the Internet gateway for outgoing. IPV4 traffic."
  type        = string
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

variable "zone_id" {
  description = "route53 zone id needed for nat gateway"
  type        = string
}

variable "environment" {
  description = "the environment this vpc is created in (e.g. 'testing')"
  type        = string
}
