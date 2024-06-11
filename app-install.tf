resource "null_resource" "app" {

            count   = var.OD_INSTANCE_COUNT + var.SPOT_INSTANCE_COUNT

    provisioner "remote-exec" {
        connection {
            type     = "ssh"
            user     = local.SSH_USER
            password = local.SSH_PASS
            host     = element(local.INSTANCE_IPS, count.index)
        }

    inline = [
      "ansible-pull -U https://github.com/azharshaikh33/ansible.git robot-pull.yml -e ENV=${var.ENV} -e COMPONENT=${var.COMPONENT} -e APP_VERSION=${var.APP_VERSION}"
    ]
  }
}