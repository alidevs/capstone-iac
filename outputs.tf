output "bastion_public_ip" {
  value = alicloud_instance.bastion.public_ip
}

output "nlb_dns_name" {
  value = alicloud_nlb_load_balancer.http.dns_name
}

output "app_private_ips" {
  value = alicloud_instance.http[*].private_ip
}

output "redis_private_ip" {
  value = alicloud_instance.redis.private_ip
}

output "mysql_private_ip" {
  value = alicloud_instance.mysql.private_ip
}
