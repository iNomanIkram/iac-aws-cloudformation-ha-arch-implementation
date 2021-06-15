output "ALB" {
  value = {
    "DnsAddress" = aws_lb.ALB.dns_name,
    "TargetGroup" = aws_lb_target_group.TargetGroup,
     "BasionHost" = {
        "DnsAddress"  = aws_lb.ALB.dns_name ,
        "TargetGroup" = aws_lb_target_group.TargetGroup
    }
  }
}