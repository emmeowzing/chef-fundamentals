# Execute with Terraform v12.18.


/**
 * Variables
 */


locals {
  instance_type = "t2.micro"
  region = "us-east-2"
  zone = "us-east-2a"
  key = "kubernetes"
  user_data = "user-data.sh"
}


/**
 * Terraform configuration.
 */


provider "aws" {
  region = local.region
  #shared_credentials_file = "/home/brandon/.aws/credentials"
  shared_credentials_file = "/Users/brandondoyle/.aws/credentials"
  profile                 = "support-soak"
}


##
# Use a remote backend for the state file - allows you to use any computer to work
# against the same state file.
#terraform {
#  backend "s3" {
#    bucket = "terraform-state-support"
#    region = "us-east-1"
#    key    = "chef-learning/tfstate"
#  }
#}


/**
 * Set up cheap instance.
 */


data "aws_ami" "ubuntu18" {
  most_recent = true

  filter {
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*" ]
  }

  # Canonical
  owners = [
    "099720109477"
  ]
}


resource "aws_spot_instance_request" "spot" {
  ami = data.aws_ami.ubuntu18.id
  instance_type = local.instance_type
  key_name = local.key
  user_data = file(local.user_data)
}