
resource "aws_security_group" "MySql_SG" {
  name        = "${var.setting.project_title}-${var.setting.environment}-MySqlInstance-SecurityGroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc.vpc.id

  ingress {
    description      = "HTTP from vpc"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
//    cidr_blocks      = ["0.0.0.0/0"]
    security_groups = [ aws_security_group.FlaskApp_SG.id ]
//    security_groups = []

  }

  ingress {
    description      = "HTTP from vpc"
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
    Name = "${var.setting.project_title}-${var.setting.environment}-MySqlInstance-SecurityGroup"
  }
}


resource "aws_security_group" "FlaskApp_SG" {
  name        = "${var.setting.project_title}-${var.setting.environment}-FlaskApp-SecurityGroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc.vpc.id

  ingress {
    description      = "HTTP from vpc"
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
    description      = "SSH from vpc"
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
    Name = "${var.setting.project_title}-${var.setting.environment}-FlaskApp-SecurityGroup"
  }
}



resource "aws_security_group" "LoadBalancer_SG" {
  name        = "${var.setting.project_title}-${var.setting.environment}-LoadBalancer-SecurityGroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc.vpc.id

  ingress {
    description      = "HTTP from vpc"
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
    Name = "${var.setting.project_title}-${var.setting.environment}-LoadBalancer-SecurityGroup"
  }
}


resource "aws_security_group" "BastionHost_SG" {
  name        = "${var.setting.project_title}-${var.setting.environment}-BastionHost-SecurityGroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc.vpc.id

  ingress {
    description      = "SSH from vpc"
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
    Name = "${var.setting.project_title}-${var.setting.environment}-BastionHost-SecurityGroup"
  }
}