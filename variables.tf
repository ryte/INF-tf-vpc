variable "tags" {
  description = "common tags to add to the ressources"
  type        = map(string)
  default     = {}
}

variable "availability_zones" {
  description = "Region AZs this VPC should cover. Currently this would be a list of two (a, b) or three (a, b, c) AZs."
  default     = ["a", "b", "c"]
}

variable "cidr_v4" {
  description = "VPC CIDR."
  default     = "10.0.0.0/16"
}

variable "domain_internal" {
  description = "Set this to an internal domain name to be associated with the VPC."
  default     = ""
}

variable "deploy_flowlogs" {
  description = "Deploy or not deploy VPC flowlogs in CloudWatch Logs."
  default     = true
}

variable "flowlogs_retention_in_days" {
  description = "CloudWatch Logs entry retention in days."
  default     = 90
}

variable "flowlogs_traffic_type" {
  description = "The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL"
  default     = "REJECT"
}

variable "environment" {
  description = "the environment this vpc is created in (e.g. 'testing')"
  type        = string
}
