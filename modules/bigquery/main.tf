module "bigquery" {
  source  = "terraform-google-modules/bigquery/google"
  for_each = toset( var.dataset_name ) 
  version = "~> 4.4"

  dataset_id                  = each.key
  dataset_name                = each.key
  description                 = "some description"
  project_id                  = var.project_id
  location                    = "US"
  default_table_expiration_ms = 3600000
}