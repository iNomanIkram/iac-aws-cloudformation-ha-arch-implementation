
resource "aws_instance" "database" {
  ami           = var.ec2_config.ami
  instance_type = var.ec2_config.instance_type
  key_name = var.ec2_config.pem
  subnet_id = var.vpc.PrivateSubnet[2].id
  vpc_security_group_ids = [ var.security_groups.MySql_SG.id ]
  user_data = file("./modules/database/userdata.sh")


  tags = {
    Name = "${var.setting.project_title}-${var.setting.environment}-MySqlInstance"
  }
}