resource "aws_security_group" "simple_sg" {
  name        = var.sg-name
  description = "Allow SSH access from host machine and access to internet"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow 22 from host machine"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.my_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}