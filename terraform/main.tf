
module "vpc_module" {
  source = "./modules/vpc"

  ProjectTitle = var.ProjectTitle
  Environment = var.Environment

  VPC_Cidr = "10.0.0.0/24"

  PublicSubnetCidrBlock1  = "10.0.0.0/27"
  PublicSubnetCidrBlock5  = "10.0.0.128/27"

  PrivateSubnetCidrBlock2 = "10.0.0.32/27"
  PrivateSubnetCidrBlock3 = "10.0.0.64/27"
  PrivateSubnetCidrBlock4 = "10.0.0.96/27"
  PrivateSubnetCidrBlock6 = "10.0.0.160/27"
  PrivateSubnetCidrBlock7 = "10.0.0.192/27"
  PrivateSubnetCidrBlock8 = "10.0.0.224/27"
}

module "securitygroups_module" {
  source = "./modules/security-groups"

  ProjectTitle = var.ProjectTitle
  Environment = var.Environment

  VPC = module.vpc_module.VPC

  depends_on = [
    module.vpc_module.id
  ]

}

module "database_module" {
  source = "./modules/database"

  ProjectTitle = var.ProjectTitle
  Environment = var.Environment

  MySql_SG = module.securitygroups_module.MySql_SG
  Ami =  var.env_config["ami"] #"ami-0ee02acd56a52998e" # var.env_config[ami] #
  Instance_Type = var.env_config["instance_type"] #"t2.micro"  # var.env_config[instance_type] #
  PEM_Key = var.env_config["pem"] #"nomanikram-newkey"  # var.env_config[pem] #
  PrivateSubnet1c = module.vpc_module.PrivateSubnet1c

  depends_on = [
    module.securitygroups_module.id
  ]
}


module "bastionhost_module" {
  source = "./modules/bastion-host"

  ProjectTitle = var.ProjectTitle
  Environment = var.Environment

  BastionHost_SG = module.securitygroups_module.BastionHost_SG

  Ami =  var.env_config["ami"] #"ami-0ee02acd56a52998e"  # var.env_config[ami] #
  PEM_Key = var.env_config["pem"] #"nomanikram-newkey"  # var.env_config[pem] #
  Instance_Type = var.env_config["instance_type"] #"t2.micro"  # var.env_config[instance_type] #

  PublicSubnet1a = module.vpc_module.PublicSubnet1a

    depends_on = [
    module.securitygroups_module.id
  ]
}


module "asg_module" {
  source = "./modules/autoscaling-group"

  ProjectTitle = var.ProjectTitle
  Environment = var.Environment

  FlaskApp_SG = module.securitygroups_module.FlaskApp_SG

  PEM_Key = var.env_config["pem"]  # "nomanikram-newkey"

  PrivateSubnet1b = module.vpc_module.PrivateSubnet1b
  PrivateSubnet2b = module.vpc_module.PrivateSubnet2b

  TargetGroup = module.alb_module.TargetGroup

  Database = module.database_module.Database

  Instance_Type = var.env_config["instance_type"] # "t2.micro"  #
  Ami = var.env_config["ami"] #"ami-0ee02acd56a52998e"  # var.env_config[ami] #

    depends_on = [
      module.database_module.id,
      module.alb_module.id
  ]
}


module "alb_module" {
  source = "./modules/application-loadbalancer"

  ProjectTitle = var.ProjectTitle
  Environment = var.Environment

  LoadBalancer_SG = module.securitygroups_module.LoadBalancer_SG

//  PEM_Key = "nomanikram-secretkey"

  PublicSubnet1a = module.vpc_module.PublicSubnet1a
  PublicSubnet2a = module.vpc_module.PublicSubnet2a

  VPC = module.vpc_module.VPC

  depends_on = [
    module.database_module.id
  ]
}