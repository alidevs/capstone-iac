resource "alicloud_nlb_load_balancer" "http" {
  load_balancer_name = "${var.project}-nlb"
  address_type       = "Internet"
  load_balancer_type = "Network"
  vpc_id             = alicloud_vpc.main.id

  zone_mappings {
    vswitch_id = alicloud_vswitch.public_a.id
    zone_id    = data.alicloud_zones.available.zones[0].id
  }

  zone_mappings {
    vswitch_id = alicloud_vswitch.public_b.id
    zone_id    = data.alicloud_zones.available.zones[1].id
  }
}

resource "alicloud_nlb_server_group" "http" {
  server_group_name = "${var.project}-http-servers"
  vpc_id            = alicloud_vpc.main.id
  protocol          = "TCP"
}

resource "alicloud_nlb_listener" "http" {
  load_balancer_id  = alicloud_nlb_load_balancer.http.id
  listener_protocol = "TCP"
  listener_port     = 80
  server_group_id   = alicloud_nlb_server_group.http.id
}

resource "alicloud_nlb_server_group_server_attachment" "http" {
  count           = 2
  server_group_id = alicloud_nlb_server_group.http.id
  server_id       = alicloud_instance.http[count.index].id
  server_type     = "Ecs"
  port            = 80
  weight          = 100
}
