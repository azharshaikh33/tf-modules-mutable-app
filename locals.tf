locals {
  INSTANCE_IDS = concat(aws_spot_instance_request.spot.*.id ,aws_instance.od.*.id)
  INSTANCE_IPS = concat(aws_spot_instance_request.spot.*.private_ip ,aws_instance.od.*.private_ip)
  SSH_USER     = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_USERNAME"]
  SSH_PASS     = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_PASSWORD"]
}