output "DnsAddress" {
  value = aws_lb.ALB.dns_name
}

output "TargetGroup" {
  value = aws_lb_target_group.TargetGroup
}