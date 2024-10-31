resource "alicloud_key_pair" "main" {
  key_pair_name = "${var.project}-key"
  key_file      = "${var.project}-key.pem"
}
