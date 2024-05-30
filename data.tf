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

data "aws_ami" "my_ami" {
  most_recent = true
  name_regex = "Lab-Ami-With-Ansible_Installed"
  owners = ["self"]
}

