variable "project_prefix" {
  type        = string
  description = "projectPrefix name for tagging"
}
variable "instance_suffix" {
  type = string
}

variable "namespace" {
  description = "Volterra application namespace"
  type        = string
}

variable "trusted_ip" {
  type        = string
  description = "IP to allow external access"
}

variable "volterra_cloud_cred_aws" {
  description = "Name of the volterra aws credentials"
  type        = string
}

variable "aws_region" {
  description = "aws region"
  type        = string
}

variable "aws_az1" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}
variable "aws_az2" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}
variable "aws_az3" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}
variable "vpc_id" {}

variable "internal_subnets" {
  type = map
}
variable "ssh_public_key" {}

variable k8s_cluster_name {
  type = string
}
variable k8s_cluster_namespace {
  type = string
}
