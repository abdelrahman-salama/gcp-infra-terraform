module "gcs_buckets" {
    source  =  "./modules/bucktes/"
}

module "bigquery" {
    source  =  "./modules/bigquery/"
}

module "networking" {
    source  =  "./modules/networking/"

}

module "gke" {
    source  =  "./modules/gke-cluster/"
    private_subnet_name = module.networking.private_subnets[0]
    pod_subnet_secondary_range = flatten([for i in module.networking.subnets_secondary_ranges[0] : i.range_name])[0]
    svc_subnet_secondary_range = flatten([for i in module.networking.subnets_secondary_ranges[0] : i.range_name])[1]
}


module "vm" {
    source  =  "./modules/vm_instance/"
    depends_on = [module.networking]
    private_subnet_name = module.networking.private_subnets[0]

}