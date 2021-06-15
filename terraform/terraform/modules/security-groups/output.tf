output "SecurityGroups" {
  value = {
    "MySql_SG"=aws_security_group.MySql_SG,
    "FlaskApp_SG"=aws_security_group.FlaskApp_SG,
    "LoadBalancer_SG"=aws_security_group.LoadBalancer_SG,
    "BastionHost_SG"=aws_security_group.BastionHost_SG
  }
}