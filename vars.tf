variable "private_subnets_names" {
  description = "private subnet range ip"
  type        = list(string)
  default     = []
}

variable "subnets_secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets"
  default     = {}
}