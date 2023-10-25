data "aws_ami" "Ubuntu_22" {
  most_recent      = true
  name_regex = "ubuntu"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "instance" {
  ami               = data.aws_ami.Ubuntu_22.id
  instance_type     = "t2.micro"
  availability_zone = "${local.region}a"
  key_name          = aws_key_pair.key_pair.id
#   user_data         = file("")
  subnet_id         = local.subnet

  vpc_security_group_ids = [
     aws_security_group.access-ssh.id,
     aws_security_group.traffic-to-net.id,
     aws_security_group.allow-icmp.id,
]
  tags                   = merge(var.common_tags, { Name = "OpenVPN" })
}