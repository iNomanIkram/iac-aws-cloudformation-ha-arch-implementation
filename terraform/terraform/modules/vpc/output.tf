output "VPC" {
  value = {
    "vpc" = aws_vpc.VPC
    "PublicSubnet"  = aws_subnet.PublicSubnet,
    "PrivateSubnet" = aws_subnet.PrivateSubnet,

  }
}
