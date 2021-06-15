output "Output" {
  value = {
    "AlbDnsAddress" =  "http://${module.alb_module.ALB.DnsAddress}"
  }
}