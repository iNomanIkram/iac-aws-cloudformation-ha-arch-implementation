//output "VPC" {
//  value = {
//    "vpc" = aws_vpc.VPC
//    "PublicSubnet1a"  = aws_subnet.PublicSubnet1a,
//    "PublicSubnet2a"  = aws_subnet.PublicSubnet2a,
//    "PrivateSubnet1b" = aws_subnet.PrivateSubnet1b,
//    "PrivateSubnet1c" = aws_subnet.PrivateSubnet1c,
//    "PrivateSubnet1d" = aws_subnet.PrivateSubnet1d,
//    "PrivateSubnet2b" = aws_subnet.PrivateSubnet2b,
//    "PrivateSubnet2c" = aws_subnet.PrivateSubnet2c,
//    "PrivateSubnet2d" = aws_subnet.PrivateSubnet2d
//  }
//}

output "VPC" {
  value = {
    "vpc" = aws_vpc.VPC
    "PublicSubnet"  = aws_subnet.PublicSubnet,
//    "PublicSubnet2a"  = aws_subnet.PublicSubnet2a,
    "PrivateSubnet" = aws_subnet.PrivateSubnet,
//    "PrivateSubnet1c" = aws_subnet.PrivateSubnet1c,
//    "PrivateSubnet1d" = aws_subnet.PrivateSubnet1d,
//    "PrivateSubnet2b" = aws_subnet.PrivateSubnet2b,
//    "PrivateSubnet2c" = aws_subnet.PrivateSubnet2c,
//    "PrivateSubnet2d" = aws_subnet.PrivateSubnet2d
  }
}
