provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_version = ">= 0.12.3"
}


module "this" {
  source = "giuliocalzolari/windows-password-rotation/aws"
  # source = "../"
  version  = "1.0.3"
  app_name = "app1"
}

module "this2" {
  source                  = "giuliocalzolari/windows-password-rotation/aws"
  version                 = "1.0.3"
  app_name                = "app2"
  ssm_target_key          = "tag:Demo"
  schedule                = "rate(2 days)"
  enabled_cloudwatch_task = false
}
