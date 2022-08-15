module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 4.0"

    project_id   = var.project_id
    network_name = var.vpc_name
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-central1"
            subnet_private_access = "false"
            subnet_flow_logs      = "true"
            description           = "Private Subnet"
            subnet_private_access = true
        },

    {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-central1"
            subnet_private_access = "false"
            subnet_flow_logs      = "true"
            description           = "Private Subnet"
            subnet_private_access = true
        }
    ]

    secondary_ranges = {
        subnet-01 = [
            {
                range_name    = "private-subnet-secondary-01"
                ip_cidr_range = "192.168.64.0/24"
            },
            {
                range_name    = "private-subnet-secondary-02"
                ip_cidr_range = "192.168.65.0/24"
            },
        ]
    }

    routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        },
        {
            name                   = "app-proxy"
            description            = "route through proxy to reach app"
            destination_range      = "10.50.10.0/24"
            tags                   = "app-proxy"
            next_hop_instance      = var.instance_name
            next_hop_instance_zone = "us-central1-c"
        },
    ]

    firewall_rules = [{
    name                    = "allow-ssh-ingress-from-iap"
    description             = null
    direction               = "INGRESS"
    priority                = null
    ranges                  = ["35.235.240.0/20"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
    }]


}

# create a public ip for nat service
resource "google_compute_address" "nat-ip" {
  name = "${var.vpc_name}-nat-ip"
  project = var.project_id
  region  = var.region

}

# create a nat to allow private instances connect to internet
resource "google_compute_router" "nat-router" {
  name = "${var.vpc_name}-nat-router"
  network = module.vpc.network_name

}

resource "google_compute_router_nat" "nat-gateway" {
  name = "${var.vpc_name}-nat-gateway"
  router = google_compute_router.nat-router.name
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = [ google_compute_address.nat-ip.self_link ]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES" 
  depends_on = [ google_compute_address.nat-ip ]
}

output "nat_ip_address" {
  value = google_compute_address.nat-ip.address
}