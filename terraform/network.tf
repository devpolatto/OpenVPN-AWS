resource "aws_network_interface" "openvpn-network_interface" {
  subnet_id       = local.subnet
  private_ips     = [var.subnet.primary_ipv4]

  security_groups = [
     aws_security_group.access-ssh.id,
     aws_security_group.traffic-to-net.id,
     aws_security_group.allow-icmp.id,
     aws_security_group.openvpn-tunnel-port.id,
  ]

}

resource "aws_eip" "this" {
  network_interface         = aws_network_interface.openvpn-network_interface.id
  associate_with_private_ip = var.subnet.primary_ipv4

  depends_on = [ aws_network_interface.openvpn-network_interface ]
}