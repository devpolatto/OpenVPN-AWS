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

########################## Access SSH ##########################

########################## Internet ##########################
resource "aws_security_group" "traffic-to-net" {
  name        = "${lookup(var.common_tags, "ALIAS_PROJECT", "sg_public")} - Internet Access"
  description = "Internet access"
  vpc_id      = local.vpc_id

  tags = merge(var.common_tags, { Name = "${lookup(var.common_tags, "ALIAS_PROJECT")} - Internet Access"})
}

resource "aws_security_group_rule" "allowed_all_traffic_to_net" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.traffic-to-net.id
}
########################## Internet ##########################

########################## ping (ICMP) ##########################
resource "aws_security_group" "allow-icmp" {
  name        = "${lookup(var.common_tags, "ALIAS_PROJECT", "sg_public")} - Allow Ping"
  description = "Ping"
  vpc_id      = local.vpc_id

  tags = merge(var.common_tags, { Name = "${lookup(var.common_tags, "ALIAS_PROJECT")} - Allow Ping"})
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
########################## ping (ICMP) ##########################