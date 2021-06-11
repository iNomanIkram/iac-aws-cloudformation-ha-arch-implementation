
resource "aws_security_group" "MySql_SG" {
  name        = "${var.ProjectTitle}-${var.Environment}-MySqlInstance-SecurityGroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.VPC.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
//    cidr_blocks      = ["0.0.0.0/0"]
    security_groups = [ aws_security_group.FlaskApp_SG.id ]
//    security_groups = []

  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"

    security_groups = [ aws_security_group.FlaskApp_SG.id ]

  }
  egress {
    description      = "Outgoing"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-MySqlInstance-SecurityGroup"
  }
}


resource "aws_security_group" "FlaskApp_SG" {
  name        = "${var.ProjectTitle}-${var.Environment}-FlaskApp-SecurityGroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.VPC.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
//    cidr_blocks      = ["0.0.0.0/0"]
    security_groups = [
      aws_security_group.LoadBalancer_SG.id,
      aws_security_group.BastionHost_SG.id
    ]

  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
//    cidr_blocks      = ["0.0.0.0/0"]
     security_groups = [
      aws_security_group.LoadBalancer_SG.id
//     , aws_security_group.BastionHost_SG.id
    ]

  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_groups = []

  }

  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-FlaskApp-SecurityGroup"
  }
}



resource "aws_security_group" "LoadBalancer_SG" {
  name        = "${var.ProjectTitle}-${var.Environment}-LoadBalancer-SecurityGroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.VPC.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Outgoing"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-LoadBalancer-SecurityGroup"
  }
}


resource "aws_security_group" "BastionHost_SG" {
  name        = "${var.ProjectTitle}-${var.Environment}-BastionHost-SecurityGroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.VPC.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Outgoing"
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-BastionHost-SecurityGroup"
  }
}