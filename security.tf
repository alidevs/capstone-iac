resource "alicloud_security_group" "bastion" {
  name   = "${var.project}-bastion-sg"
  vpc_id = alicloud_vpc.main.id
}

resource "alicloud_security_group_rule" "bastion_ssh" {
  security_group_id = alicloud_security_group.bastion.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "22/22"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group" "http" {
  name   = "${var.project}-http-sg"
  vpc_id = alicloud_vpc.main.id
}

resource "alicloud_security_group_rule" "http_ssh" {
  security_group_id        = alicloud_security_group.http.id
  type                     = "ingress"
  ip_protocol              = "tcp"
  port_range               = "22/22"
  source_security_group_id = alicloud_security_group.bastion.id
}

resource "alicloud_security_group_rule" "http_web" {
  security_group_id = alicloud_security_group.http.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "80/80"
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_mysql" {
  security_group_id = alicloud_security_group.http.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "3306/3306"
  cidr_ip           = "10.0.0.0/8"
}

resource "alicloud_security_group_rule" "allow_redis" {
  security_group_id = alicloud_security_group.http.id
  type              = "ingress"
  ip_protocol       = "tcp"
  port_range        = "6379/6379"
  cidr_ip           = "10.0.0.0/8"
}
