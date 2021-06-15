


resource "aws_instance" "web" {
  ami = var.ec2_config.ami
  instance_type = var.ec2_config.instance_type
  key_name = var.ec2_config.pem
  subnet_id = var.vpc.PublicSubnet[0].id
  vpc_security_group_ids = [ var.security_groups.BastionHost_SG.id ]


  tags = {
    Name = "${var.setting.project_title}-${var.setting.environment}-BastionHost"
  }
}