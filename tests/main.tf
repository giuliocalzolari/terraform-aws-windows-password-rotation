provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_version = ">= 0.12.3"
}


module "this" {
  source = "giuliocalzolari/windows-password-rotation/aws"
  # source = "../"
  version = "1.0.1"
}
