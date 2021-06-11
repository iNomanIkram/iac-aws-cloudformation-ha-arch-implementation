# Create a VPC

resource "aws_vpc" "VPC" {
  cidr_block = var.VPC_Cidr
  enable_dns_hostnames = true

  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-VPC"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id


  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-IGW"
  }
}

resource "aws_subnet" "PublicSubnet1a" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = var.PublicSubnetCidrBlock1
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-PublicSubnet1a"
  }
}

resource "aws_subnet" "PrivateSubnet1b" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = var.PrivateSubnetCidrBlock2
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-PrivateSubnet1b"
  }
}

resource "aws_subnet" "PrivateSubnet1c" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = var.PrivateSubnetCidrBlock3
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-PrivateSubnet1c"
  }
}

resource "aws_subnet" "PrivateSubnet1d" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = var.PrivateSubnetCidrBlock4
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-PrivateSubnet1d"
  }
}

resource "aws_subnet" "PublicSubnet2a" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = var.PublicSubnetCidrBlock5
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-PublicSubnet2a"
  }
}


resource "aws_subnet" "PrivateSubnet2b" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = var.PrivateSubnetCidrBlock6
  availability_zone = "us-east-1b"
  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-PrivateSubnet2b"
  }
}


resource "aws_subnet" "PrivateSubnet2c" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = var.PrivateSubnetCidrBlock7
  availability_zone = "us-east-1b"
  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-PrivateSubnet2c"
  }
}

resource "aws_subnet" "PrivateSubnet2d" {
  vpc_id     = aws_vpc.VPC.id
  cidr_block = var.PrivateSubnetCidrBlock8
  availability_zone = "us-east-1b"
  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-PrivateSubnet2d"
  }
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }


  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-PublicRT"
  }
}

resource "aws_eip" "NAT_EIP" {
  vpc = true
}

resource "aws_nat_gateway" "NAT-GW" {
    allocation_id = aws_eip.NAT_EIP.id
    subnet_id     = aws_subnet.PublicSubnet1a.id

  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-NatGW"
  }
}

resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NAT-GW.id
  }


  tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-PrivateRT"
  }
}

resource "aws_route_table_association" "PublicSubnetCidrBlock1RTA" {
  subnet_id      = aws_subnet.PublicSubnet1a.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_route_table_association" "PublicSubnetCidrBlock5RTA" {
  subnet_id      = aws_subnet.PublicSubnet2a.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_route_table_association" "PrivateSubnetCidrBlock2RTA" {
  subnet_id      = aws_subnet.PrivateSubnet1b.id
  route_table_id = aws_route_table.PrivateRT.id
}

resource "aws_route_table_association" "PrivateSubnetCidrBlock3RTA" {
  subnet_id      = aws_subnet.PrivateSubnet1c.id
  route_table_id = aws_route_table.PrivateRT.id
}

resource "aws_route_table_association" "PrivateSubnetCidrBlock4RTA" {
  subnet_id      = aws_subnet.PrivateSubnet1d.id
  route_table_id = aws_route_table.PrivateRT.id
}


resource "aws_route_table_association" "PrivateSubnetCidrBlock6RTA" {
  subnet_id      = aws_subnet.PrivateSubnet2b.id
  route_table_id = aws_route_table.PrivateRT.id
}

resource "aws_route_table_association" "PrivateSubnetCidrBlock7RTA" {
  subnet_id      = aws_subnet.PrivateSubnet2c.id
  route_table_id = aws_route_table.PrivateRT.id
}

resource "aws_route_table_association" "PrivateSubnetCidrBlock8RTA" {
  subnet_id      = aws_subnet.PrivateSubnet2d.id
  route_table_id = aws_route_table.PrivateRT.id
}

