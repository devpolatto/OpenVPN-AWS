<img align='right' src="POC_OpenVPN-topology.png" style='height: auto; width: 100%'>

<h1 style='text-align: center'>OpenVPN AWS Lab</h1>


# Steps

[ X ] - provision an EC2 instance with terraform \
[  ] - Install OpenVPN source code on an EC2 instance


# Terraform
- configs locals.tf
```hcl
locals {
  region = "" # região da infraestrutura cloud
  profile = "" # profile default ou personalizado em seu .aws/credentials
}
```
## OpenVPN Server resources
To build the EC2 instances of OpenVPN, the following resources were used:
- aws_ami : `The instance model is chosen dynamically`
- aws_instance
- aws_network_interface : `To link an Elastic IP we need a static ip`
- aws_eip