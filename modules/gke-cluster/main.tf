# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

data "google_compute_subnetwork" "subnetwork" {
  name    = var.private_subnet_name
  project = var.project_id
  region  = var.region
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version                    = "13.0.0"
  project_id                 = var.project_id
  name                       = "gke-test-1"
  region                     = var.region
  zones                      = ["us-central1-a", "us-central1-f"]
  network                    = var.vpc_name
  subnetwork                 = var.private_subnet_name
  ip_range_pods              = var.pod_subnet_secondary_range
  ip_range_services          = var.svc_subnet_secondary_range
  enable_private_endpoint    = true
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "10.0.0.0/28"
  http_load_balancing        = false
  network_policy             = true
  horizontal_pod_autoscaling = true
  default_max_pods_per_node  = 30

  master_authorized_networks = [
    {
      cidr_block   = data.google_compute_subnetwork.subnetwork.ip_cidr_range
      display_name = "VPC"
    },
  ]

  node_pools = [
    {
      name                      = "default-node-pool"
      node_count                = 1
      machine_type              = "e2-standard-2"
      node_locations            = "us-central1-b,us-central1-c"
      #min_count                 = 2
      #max_count                 = 3
      autoscaling               = false
      local_ssd_count           = 0
      spot                      = false
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      enable_gvnic              = false
      auto_repair               = true
      auto_upgrade              = true
      create_service_account    = true
      service_account           = google_service_account.sa.email
      preemptible               = false
      #initial_node_count        = 2
    },
  ]
}