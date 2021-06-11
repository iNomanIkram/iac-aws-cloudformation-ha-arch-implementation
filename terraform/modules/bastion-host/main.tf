


resource "aws_instance" "web" {
  ami = var.Ami
  instance_type = var.Instance_Type
  key_name = var.PEM_Key
  subnet_id = var.PublicSubnet1a.id
  vpc_security_group_ids = [ var.BastionHost_SG.id ]


  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-BastionHost"
  }
}