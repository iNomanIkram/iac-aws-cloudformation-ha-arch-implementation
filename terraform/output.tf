output "DnsAddress" {
  value = "http://${module.alb_module.DnsAddress}"
}