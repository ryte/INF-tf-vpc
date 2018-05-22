variable "tags" {
  type = "map"
  description = "common tags to add to the ressources"
  default = {}
}

variable "availability_zones" {
  default     = ["a", "b", "c"]
  description = "Region AZs this VPC should cover. Currently this would be a list of two (a, b) or three (a, b, c) AZs."
}

variable "cidr_v4" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR."
}

variable "domain_internal" {
  default     = ""
  description = "Set this to an internal domain name to be associated with the VPC."
}

variable "deploy_flowlogs" {
  default     = true
  description = "Deploy or not deploy VPC flowlogs in CloudWatch Logs."
}

variable "flowlogs_retention_in_days" {
  default     = 90
  description = "CloudWatch Logs entry retention in days."
}

variable "flowlogs_traffic_type" {
  default     = "REJECT"
  description = "The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL"
}
