module "gcs_buckets" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> 2.2"
  project_id  = var.project_id
  names = var.buckets_names
  prefix = "gcplab"
  location = "us-central1"
  storage_class = "STANDARD"
  set_admin_roles = true
  admins = ["user:abdelrahman.fathi.salama@gmail.com"]
  versioning = {
    first = true
  }
  bucket_admins = {
    second = "user:abdelrahman.fathi.salama@gmail.com"
  }
}