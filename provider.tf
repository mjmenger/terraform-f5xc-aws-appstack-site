terraform {
  required_version = ">= 0.12.7"

  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = ">=0.11.32"
    }
    aws = ">= 2.24"
  }
}
