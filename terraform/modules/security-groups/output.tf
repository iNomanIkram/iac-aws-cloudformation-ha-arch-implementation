output "MySql_SG" {
  value = aws_security_group.MySql_SG
}

output "FlaskApp_SG" {
  value = aws_security_group.FlaskApp_SG
}


output "LoadBalancer_SG" {
  value = aws_security_group.LoadBalancer_SG
}

output "BastionHost_SG" {
  value = aws_security_group.BastionHost_SG
}
