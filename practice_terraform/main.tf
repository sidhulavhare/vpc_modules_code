provider "aws" {              
   region = var.region             # configure provider 
   access_key  = 	""
   secret_key = ""

}

# create the vpc

module "vpc" {
  source                       =   "./modules/vpc"
  region                       =   var.region
  project_name                 =   var.project_name
  vpc_cidr                     =   var.vpc_cidr
  public_subnet_az1_cidr       =   var.public_subnet_az1_cidr
  public_subnet_az2_cidr       =   var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  =   var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  =   var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr =  var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr =  var.private_data_subnet_az2_cidr


}




# create nat gatgateway

module "nat-gateway" {
  source                         = "./modules/nat-gateway"
  public_subnet_az1_id           = module.vpc.public_subnet_az1_id
  internet_gateway               = module.vpc.internet_gateway
  public_subnet_az2_id           = module.vpc.public_subnet_az2_id  
  vpc_id                         = module.vpc.vpc_id 
  private_app_subnet_az1_id      = module.vpc.private_app_subnet_az1_id
  private_data_subnet_az1_id     = module.vpc.private_data_subnet_az1_id
  private_app_subnet_az2_id      = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az2_id     = module.vpc.private_data_subnet_az2_id
}