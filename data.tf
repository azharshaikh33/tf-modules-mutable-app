data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "azhar-roboshop-project-tfstate"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"

    }
}

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "azhar-roboshop-project-tfstate"
    key    = "alb/${var.ENV}/terraform.tfstate"
    region = "us-east-1"

    }
}

data "aws_ami" "My_ami" {
  most_recent = true
  name_regex = "Lab-Ami-With-Ansible_Installed"
  owners = ["self"]
}

data "aws_secretsmanager_secret" "secrets" {
  name = "roboshop1/secrets"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id     = data.aws_secretsmanager_secret.secrets.id
}

