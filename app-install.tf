resource "null_resource" "name" {

            count   = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT

    provisioner "remote-exec" {
        connection {
            type     = "ssh"
            user     = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_USERNAME"]
            password = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["SSH_PASSWORD"]
            host     = element(local.INSTANCE_IPS, count.index)
        }

    inline = [
      "ansible-pull -U https://github.com/azharshaikh33/ansible.git robot-pull.yml -e ENV=dev -e COMPONENT=mongodb"
    ]
  }
}