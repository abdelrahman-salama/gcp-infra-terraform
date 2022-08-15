variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "test"
}

variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
  default     = "magnetic-runway-358712"
}

variable "instance_name" {
  description = "The VM Name"
  type        = string
  default     = "test-instance"
}

variable "region" {
  description = "Region"
  type        = string
  default     = "us-central1"
}