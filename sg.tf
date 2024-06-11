# Creating SG

# Create a security group
resource "aws_security_group" "allow_app" {
  name        = "roboshop-${var.COMPONENT}-${var.ENV}-sg"
  description = "roboshop-${var.COMPONENT}-${var.ENV}-sg"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

  # Inbound rules
  ingress {
    description = "Application port"
    from_port   = var.APP_PORT
    to_port     = var.APP_PORT
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  ingress {
    description = "SSH PORT"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-${var.COMPONENT}-${var.ENV}-sg"
  }
}

# Declare the id of the sg id.
# output "sg_id" {
#   value = aws_security_group.allow_ssh_sg.id
# }