variable "subnet" {
  type = object({
    primary_ipv4 = string 
  })

  default = {
    primary_ipv4 = "192.168.10.20"
  }
}

variable "common_tags" {
  type = map(any)
  default = {
    ENV           = "lab"
    LABID         = "OpenVPN"
    ALIAS_PROJECT = "POC : OpenVPN P2S"
    MANAGED_BY    = "Terraform"
  }
}