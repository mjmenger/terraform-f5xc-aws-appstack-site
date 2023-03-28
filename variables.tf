variable "buildSuffix" {
  type        = string
  default     = null
  description = "random build suffix for resources"
}
variable "projectPrefix" {
  type        = string
  description = "projectPrefix name for tagging"
}
variable "instanceSuffix" {
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

variable "volterraCloudCredAWS" {
  description = "Name of the volterra aws credentials"
  type        = string
}

variable "awsRegion" {
  description = "aws region"
  type        = string
}

variable "awsAz1" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}
variable "awsAz2" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}
variable "awsAz3" {
  description = "Availability zone, will dynamically choose one if left empty"
  type        = string
  default     = null
}

variable "volterraUrl" {
  description = "url of volterra api"
  type        = string
  default     = null
}
variable "volterraTenant" {
  description = "Tenant of Volterra"
  type        = string
}
variable "vpcId" {}
variable "externalSubnets" {
  type = map
}
variable "internalSubnets" {
  type = map
}
variable "workloadSubnets" {
  type = map
}
variable "spokeVpcId" {}
variable "spoke2VpcId" {}
variable "ssh_public_key" {}

variable k8s_cluster_name {
  type = string
}
variable k8s_cluster_namespace {
  type = string
}
