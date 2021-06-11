
resource "aws_instance" "database" {
  ami           = var.Ami
  instance_type = var.Instance_Type
  key_name = var.PEM_Key
  subnet_id = var.PrivateSubnet1c.id
  vpc_security_group_ids = [ var.MySql_SG.id ]
  user_data = file("./modules/database/userdata.sh")


  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-MySqlInstance"
  }
}