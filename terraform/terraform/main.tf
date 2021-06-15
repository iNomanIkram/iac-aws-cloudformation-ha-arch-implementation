
module "vpc_module" {
  source = "./modules/vpc"

  setting = var.setting
  vpc =     var.vpc

}

module "securitygroups_module" {
  source = "./modules/security-groups"

  setting = var.setting

  vpc = module.vpc_module.VPC

  depends_on = [
    module.vpc_module.id
  ]

}

module "database_module" {
  source = "./modules/database"

  setting = var.setting
  ec2_config = var.ec2_config

  vpc             =  module.vpc_module.VPC
  security_groups =  module.securitygroups_module.SecurityGroups

  depends_on = [
    module.securitygroups_module.id
  ]
}


module "bastionhost_module" {
  source = "./modules/bastion-host"

  setting = var.setting
  ec2_config = var.ec2_config

  vpc =  module.vpc_module.VPC
  security_groups =  module.securitygroups_module.SecurityGroups

  depends_on = [
    module.securitygroups_module.id
  ]
}


module "asg_module" {
  source = "./modules/autoscaling-group"

  ec2_config = var.ec2_config
  setting = var.setting
  asg = var.asg

  vpc =  module.vpc_module.VPC
  security_groups =  module.securitygroups_module.SecurityGroups
  ALB = module.alb_module.ALB
  database = module.database_module.Database

  depends_on = [
      module.database_module.id,
      module.alb_module.id
  ]
}


module "alb_module" {
  source = "./modules/application-loadbalancer"

  setting = var.setting
  ec2_config = var.ec2_config

  vpc =  module.vpc_module.VPC
  security_groups =  module.securitygroups_module.SecurityGroups

  depends_on = [
    module.database_module.id
  ]
}