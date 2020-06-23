data "aws_ip_ranges" "european_ec2" {
  regions  = ["us-west-1", "us-central-1"]
  services = ["ec2"]
}

resource "aws_security_group" "from_europe" {
  name = "from_europe"

  ingress {
    from_port        = "443"
    to_port          = "443"
    protocol         = "tcp"
    cidr_blocks      = data.aws_ip_ranges.european_ec2.cidr_blocks
    ipv6_cidr_blocks = data.aws_ip_ranges.european_ec2.ipv6_cidr_blocks
  }

  tags = {
    CreateDate = "${data.aws_ip_ranges.european_ec2.create_date}"
    SyncToken  = "${data.aws_ip_ranges.european_ec2.sync_token}"
  }
}