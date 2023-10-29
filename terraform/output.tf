output "OpenVPN_Server" {
  value = {
     "Instance_Name": "${aws_instance.instance.tags.Name}",
     "Availability_zone": aws_instance.instance.availability_zone
     "Network": {
          "private_ips": ["${aws_network_interface.openvpn-network_interface.private_ips}"],
          "public_ip": aws_instance.instance.public_ip
     }
  }
}