variable "private_subnet_name" {}

variable "pod_subnet_secondary_range" {
  type        = string
  description = "The _name_ of the secondary subnet ip range to use for pods"
}

variable "svc_subnet_secondary_range" {
  type        = string
  description = "The _name_ of the secondary subnet ip range to use for pods"
}


variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
  default     = "magnetic-runway-358712"
}

variable "region" {
  description = "Region"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "test"
}

variable "account_id" {
  description = "The name of instance service account"
  type        = string
  default     = "nodes-sa"
}