output "private_subnets" {
  value = "${module.vpc.subnets_names}"
}

output "subnets_secondary_ranges" {
  value = "${module.vpc.subnets_secondary_ranges}"
}

#output "subnets_secondary_ranges" {
#  #value       = flatten(module.vpc.subnets_secondary_ranges[0].range_name)[0]
#  value       = flatten([for i in module.vpc.subnets_secondary_ranges[0] : i.range_name])[0]
#  description = "The secondary ranges associated with these subnets"
#}