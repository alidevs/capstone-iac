data "alicloud_zones" "available" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "main" {
  vpc_name   = "${var.project}-vpc"
  cidr_block = "10.0.0.0/8"
}

resource "alicloud_vswitch" "public_a" {
  vpc_id       = alicloud_vpc.main.id
  cidr_block   = "10.0.1.0/24"
  zone_id      = data.alicloud_zones.available.zones[0].id
  vswitch_name = "${var.project}-public-a"
}

resource "alicloud_vswitch" "public_b" {
  vpc_id       = alicloud_vpc.main.id
  cidr_block   = "10.0.2.0/24"
  zone_id      = data.alicloud_zones.available.zones[1].id
  vswitch_name = "${var.project}-public-b"
}

resource "alicloud_vswitch" "private" {
  vpc_id       = alicloud_vpc.main.id
  cidr_block   = "10.0.3.0/24"
  zone_id      = data.alicloud_zones.available.zones[0].id
  vswitch_name = "${var.project}-private"
}

resource "alicloud_nat_gateway" "main" {
  vpc_id           = alicloud_vpc.main.id
  nat_gateway_name = "${var.project}-nat"
  payment_type     = "PayAsYouGo"
  vswitch_id       = alicloud_vswitch.public_a.id
  nat_type         = "Enhanced"
}

resource "alicloud_eip_address" "nat" {
  address_name         = "${var.project}-nat"
  bandwidth            = "100"
  internet_charge_type = "PayByTraffic"
}

resource "alicloud_eip_association" "nat" {
  allocation_id = alicloud_eip_address.nat.id
  instance_id   = alicloud_nat_gateway.main.id
  instance_type = "Nat"
}

resource "alicloud_snat_entry" "private" {
  snat_table_id     = alicloud_nat_gateway.main.snat_table_ids
  source_vswitch_id = alicloud_vswitch.private.id
  snat_ip           = alicloud_eip_address.nat.ip_address
}
