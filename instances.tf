resource "alicloud_instance" "bastion" {
  instance_name = "${var.project}-bastion"
  instance_type = var.instance_type
  image_id      = var.image_id

  security_groups            = [alicloud_security_group.bastion.id]
  vswitch_id                 = alicloud_vswitch.public_a.id
  key_name                   = alicloud_key_pair.main.key_pair_name
  internet_max_bandwidth_out = 10

  system_disk_category = "cloud_essd"
  system_disk_size     = 40

  user_data = file("scripts/bastion-init.sh")
}

resource "alicloud_instance" "http" {
  count         = 2
  instance_name = "${var.project}-http-${count.index + 1}"
  instance_type = var.instance_type
  image_id      = var.image_id

  security_groups = [alicloud_security_group.http.id]
  vswitch_id      = alicloud_vswitch.private.id
  key_name        = alicloud_key_pair.main.key_pair_name

  system_disk_category = "cloud_essd"
  system_disk_size     = 40

  user_data = base64encode(
    templatefile("${path.module}/scripts/http-init.tpl",
      {
        redis_host = alicloud_instance.redis.private_ip
        mysql_host = alicloud_instance.mysql.private_ip
      }
    )
  )
}
