#data "google_compute_default_service_account" "default" {
#}

resource "google_service_account" "sa" {
  account_id   = var.account_id
  display_name = var.account_id
}

#resource "google_service_account_iam_member" "admin-account-iam" {
#  service_account_id = google_service_account.sa.name
#  role               = "roles/iam.serviceAccountUser"
#  member             = "serviceAccount:${google_service_account.sa.email}"
#}

#resource "google_service_account_iam_member" "gce-account-iam" {
#  service_account_id = google_service_account.sa.name
#  role               = "roles/storage.admin"
#  member             = "serviceAccount:${google_service_account.sa.email}"
#}

resource "google_storage_bucket_iam_member" "bucket-1" {
  bucket = "gcplab-us-central1-test1"
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_storage_bucket_iam_member" "bucket-2" {
  bucket = "gcplab-us-central1-test2"
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_storage_bucket_iam_member" "bucket-3" {
  bucket = "gcplab-us-central1-test3"
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "gce-account-iam" {
  project             = "magnetic-runway-358712"
  #service_account_id = google_service_account.sa.name
  role               = "roles/container.admin"
  member             = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_storage_bucket_iam_member" "viewer" {
  bucket = "us.artifacts.magnetic-runway-358712.appspot.com"
  role = "roles/storage.legacyBucketWriter"
  member = "serviceAccount:${google_service_account.sa.email}"
}