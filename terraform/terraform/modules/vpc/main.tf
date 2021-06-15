data "aws_availability_zones" "available" {
  state = "available"
}

locals{
  public_subnets  = [
    "1a",
    "2a"
  ]
  private_subnets = [
    "2b",
    "2c",
    "3a",
    "3b",
    "4a",
    "4b"
    ]

  az_arr_length = length(data.aws_availability_zones.available)
}

# Create a VPC
resource "aws_vpc" "VPC" {
  cidr_block = var.vpc.vpc_cidr

  enable_dns_hostnames = true

  tags = {
    Name = "${var.setting.project_title}-${var.setting.environment}-VPC"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id


  tags = {
    Name = "${var.setting.project_title}-${var.setting.environment}-IGW"
  }
}

resource "aws_subnet" "PublicSubnet" {
  vpc_id     = aws_vpc.VPC.id

  count = length(var.vpc.public_cidr)
  cidr_block = var.vpc.public_cidr[count.index] #each.value #var.vpc.public_cidr[0]

  # Issue Fixed: Dynamic number of AZs
  # local var defined -> az_arr_length = length(data.aws_availability_zones.available)
  availability_zone =   data.aws_availability_zones.available.names[count.index%local.az_arr_length]  #? data.aws_availability_zones.available.names[0] : data.aws_availability_zones.available.names[1] #data.aws_availability_zones.available.names[0] #var.setting.availability_zones[0] # "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.setting.project_title}-${var.setting.environment}-PublicSubnet${count.index}"
  }
}

resource "aws_subnet" "PrivateSubnet" {
  vpc_id     = aws_vpc.VPC.id
  count = length(var.vpc.private_cidr)
  cidr_block = var.vpc.private_cidr[count.index]#var.vpc.private_cidr[0]
  availability_zone = data.aws_availability_zones.available.names[count.index%local.az_arr_length] # count.index%2==0 ? data.aws_availability_zones.available.names[0] : data.aws_availability_zones.available.names[1] #var.setting.availability_zones[0]  # "us-east-1a"
  tags = {
    Name = "${var.setting.project_title}-${var.setting.environment}-PrivateSubnet${count.index}"
  }
}


resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }


  tags = {
    Name = "${var.setting.project_title}-${var.setting.environment}-PublicRT"
  }
}

resource "aws_eip" "NAT_EIP" {
  vpc = true
}

resource "aws_nat_gateway" "NAT-GW" {
    allocation_id = aws_eip.NAT_EIP.id

    subnet_id     = aws_subnet.PublicSubnet[0].id

  tags = {
    Name = "${var.setting.project_title}-${var.setting.environment}-NatGW"
  }
}

resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.NAT-GW.id
  }


  tags = {
    Name = "${var.setting.project_title}-${var.setting.environment}-PrivateRT"
  }
}

resource "aws_route_table_association" "PublicSubnetRTA" {

  count = length(aws_subnet.PublicSubnet)
  subnet_id      = aws_subnet.PublicSubnet[count.index].id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_route_table_association" "PrivateSubnetRTA" {
  count          = length(aws_subnet.PrivateSubnet)
  subnet_id      = aws_subnet.PrivateSubnet[count.index].id
  route_table_id = aws_route_table.PrivateRT.id
}
