provider "aws" {
  region = var.region-master
}

module "VPC" {
  source                   = "./VPC"
  vpc-cidr-block           = "10.0.0.0/16"
  public-subnet-cidr-block = "10.0.1.0/24"
  vpc-name                 = var.vpc-name
}

module "SG" {
  source  = "./SG"
  sg-name = var.sg-name
  vpc_id  = module.VPC.vpc_id
}

module "EC2" {
  source                      = "./EC2"
  instance-name               = var.instance-name
  instance-type               = var.instance-type
  public_subnet               = module.VPC.public_subnet_id
  vpc_security_group_ids      = module.SG.aws_sg
  associate_public_ip_address = true
}
