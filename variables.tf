variable "region-master" {
  type    = string
  default = "eu-west-2"
}

# VPC Variables

variable "vpc-name" {
  type        = string
  description = "The name that we will give to our VPC"
  default     = "Simple-VPC"
}

# SG Variables

variable "sg-name" {
  type        = string
  description = "The name that we will give to our Security Group"
  default     = "Simple-SG"
}

# EC2 variables

variable "instance-name" {
  type        = string
  description = "The name that we will give to our instance"
  default     = "Simple-Instance"
}

variable "instance-type" {
  type        = string
  description = "The instance type that we will use"
  default     = "t2.micro"
}



