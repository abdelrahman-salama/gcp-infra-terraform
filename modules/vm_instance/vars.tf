variable "account_id" {
  description = "The name of instance service account"
  type        = string
  default     = "gs-access"
}

variable "instance_name" {
  description = "The VM Name"
  type        = string
  default     = "test-instance"
}


variable "machine_type" {
  description = "The VM Type"
  type        = string
  default     = "e2-medium"
}

variable "private_subnet_name" {
  description = "Private subnet"
  type        = string
  default     = "subnet-01"
}

variable "zone" {
  description = "The used zone for provisioning the infrastructure"
  type        = string
  default     = "us-central1-c"
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "test"
}