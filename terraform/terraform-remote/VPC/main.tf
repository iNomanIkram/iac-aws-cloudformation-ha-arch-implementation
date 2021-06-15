
module "vpc_module" {
  source = "./modules/vpc"

  setting = var.setting
  vpc =     var.vpc

}
