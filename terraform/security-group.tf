########################## Access SSH ##########################
resource "aws_security_group" "access-ssh" {
  name        = "Access_ssh"
  description = "SSH access via the internet"
  vpc_id      = local.vpc_id

  tags = merge(var.common_tags, { Name = "${lookup(var.common_tags, "ALIAS_PROJECT")} - Access_ssh"})
}
resource "aws_security_group_rule" "ssh_from_net" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.access-ssh.id
}

################################################################

########################## Internet ##########################
resource "aws_security_group" "traffic-to-net" {
  name        = "${lookup(var.common_tags, "ALIAS_PROJECT", "sg_public")} - Internet_Access"
  description = "Internet access"
  vpc_id      = local.vpc_id

  tags = merge(var.common_tags, { Name = "${lookup(var.common_tags, "ALIAS_PROJECT")} - Internet_Access"})
}

resource "aws_security_group_rule" "allowed_all_traffic_to_net" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.traffic-to-net.id
}
################################################################

########################## ping (ICMP) ##########################
resource "aws_security_group" "allow-icmp" {
  name        = "${lookup(var.common_tags, "ALIAS_PROJECT", "sg_public")} - Allow_Ping"
  description = "Ping"
  vpc_id      = local.vpc_id

  tags = merge(var.common_tags, { Name = "${lookup(var.common_tags, "ALIAS_PROJECT")} - Allow_Ping"})
}

resource "aws_security_group_rule" "allow-icmp_to_net" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow-icmp.id
}

resource "aws_security_group_rule" "allow-icmp_from_net" {
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow-icmp.id
}
################################################################

########################## OpenVPN port ##########################
resource "aws_security_group" "openvpn-tunnel-port" {
  name        = "${lookup(var.common_tags, "ALIAS_PROJECT", "sg_public")} - OpenVPN_Tunnel_Port"
  description = "Tunnel port"
  vpc_id      = local.vpc_id

  tags = merge(var.common_tags, { Name = "${lookup(var.common_tags, "ALIAS_PROJECT")} - OpenVPN_Tunnel_Port"})
}

resource "aws_security_group_rule" "tunnel-port" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.openvpn-tunnel-port.id
}
################################################################

#################### OpenVPN Admin GUI port #####################
resource "aws_security_group" "openvpn-admin-gui" {
  name        = "${lookup(var.common_tags, "ALIAS_PROJECT", "sg_public")} - OpenVPN_Admin_GUI_Port"
  description = "OpenVPN Admin"
  vpc_id      = local.vpc_id

  tags = merge(var.common_tags, { Name = "${lookup(var.common_tags, "ALIAS_PROJECT")} - OpenVPN_Admin_GUI_Port"})
}

resource "aws_security_group_rule" "admin-port" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.openvpn-admin-gui.id
}
################################################################