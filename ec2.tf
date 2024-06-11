# Requesting a spot instance
resource "aws_spot_instance_request" "spot" {
  count = var.SPOT_INSTANCE_COUNT
  ami           = data.aws_ami.My_ami.id
  instance_type = var.INSTANCE_TYPE
  wait_for_fulfillment = true
  vpc_security_group_ids = [aws_security_group.allow_app.id]
  subnet_id = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index)

  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}

# creating a on-demand instance

resource "aws_instance" "od" {
  count = var.OD_INSTANCE_COUNT
  ami           = data.aws_ami.My_ami.id
  instance_type = var.INSTANCE_TYPE
  vpc_security_group_ids = [aws_security_group.allow_app.id]
  subnet_id = element(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS, count.index)

  tags = {
    Name = "${var.COMPONENT}-${var.ENV}"
  }
}

resource "aws_ec2_tag" "ec2_tags" {
  count       = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT
  resource_id = element(local.INSTANCE_IDS, count.index)
  key         = "Name"
  value       = "${var.COMPONENT}-${var.ENV}"
}