resource "alicloud_instance" "mysql" {
  instance_name = "${var.project}-mysql"
  instance_type = var.instance_type
  image_id      = var.image_id

  security_groups = [alicloud_security_group.http.id]
  vswitch_id      = alicloud_vswitch.private.id
  key_name        = alicloud_key_pair.main.key_pair_name

  system_disk_category = "cloud_essd"
  system_disk_size     = 100

  user_data = filebase64("scripts/mysql-init.sh")
}

resource "alicloud_instance" "redis" {
  instance_name = "${var.project}-redis"
  instance_type = var.instance_type
  image_id      = var.image_id

  security_groups = [alicloud_security_group.http.id]
  vswitch_id      = alicloud_vswitch.private.id
  key_name        = alicloud_key_pair.main.key_pair_name

  system_disk_category = "cloud_essd"
  system_disk_size     = 40

  user_data = filebase64("scripts/redis-init.sh")
}
