variable "common_tags" {
  type = map(any)
  default = {
    ENV           = "lab"
    LABID         = "OpenVPN"
    ALIAS_PROJECT = "POC : OpenVPN P2S"
    MANAGED_BY    = "Terraform"
  }
}