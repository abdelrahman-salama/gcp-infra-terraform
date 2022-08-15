variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
  default     = "magnetic-runway-358712"
}

variable "buckets_names" {
  type    = list(string)
  default = ["test1", "test2", "test3"]
}