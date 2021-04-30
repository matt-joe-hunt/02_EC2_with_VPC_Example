output "aws_sg" {
  value       = aws_security_group.simple_sg.id
  description = "Id of the Security Group created in this module for use in EC2 module"
}