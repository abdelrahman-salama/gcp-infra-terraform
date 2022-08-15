variable "dataset_name" {
  type = list
  default = ["test1", "test2", "test3"]
}

variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
  default     = "magnetic-runway-358712"
}