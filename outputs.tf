output "private_subnets" {
  value = join(", ", module.networking.private_subnets)
}

output "subnets_secondary_ranges" {
  #value       = flatten(module.networking.subnets_secondary_ranges.range_name)
  value       = flatten([for i in module.networking.subnets_secondary_ranges[0] : i.range_name])[0]
  description = "The secondary ranges associated with these subnets"
}