
resource "aws_iam_role" "role" {
  name = "${var.app_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ssm.amazonaws.com"
      },
      "Sid": ""
    }]
}
EOF
}

resource "aws_iam_role_policy_attachment" "policy-role" {
  role = "${aws_iam_role.role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMMaintenanceWindowRole"
}

resource "aws_kms_key" "key" {
  count = var.create_kms_key ? 1 : 0
  description = "${var.app_name} key"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "a" {
  count = var.create_kms_key ? 1 : 0
  name = "alias/ssm-password-rotation"
  target_key_id = "${aws_kms_key.key[0].key_id}"
}

data "aws_kms_alias" "default_ssm_key" {
  name = "alias/aws/ssm"
}

locals {
  kms_id = var.create_kms_key ? aws_kms_key.key[0].key_id : data.aws_kms_alias.default_ssm_key.target_key_id
}

resource "aws_ssm_maintenance_window" "window" {
  name = "${var.app_name}-maintenance-window"
  schedule = "${var.schedule}"
  duration = 2
  cutoff = 1
}

resource "aws_ssm_maintenance_window_target" "target" {
  window_id = "${aws_ssm_maintenance_window.window.id}"
  name = "${var.app_name}-maintenance-window-target"
  description = "${var.app_name} maintenance window target"
  resource_type = "INSTANCE"

  targets {
    key = var.ssm_target_key
    values = var.ssm_target_values
  }
}

resource "aws_ssm_maintenance_window_task" "wtask" {
  name = "${var.app_name}-windows_password_rotation"
  max_concurrency = 2
  max_errors = 1
  priority = 1
  service_role_arn = "${aws_iam_role.role.arn}"
  task_arn = "AWSSupport-RunEC2RescueForWindowsTool"
  task_type = "RUN_COMMAND"
  window_id = "${aws_ssm_maintenance_window.window.id}"

  targets {
    key = "WindowTargetIds"
    values = ["${aws_ssm_maintenance_window_target.target.id}"]
  }

  task_invocation_parameters {
    run_command_parameters {
      timeout_seconds = 600
      parameter {
        name = "Command"
        values = ["ResetAccess"]
      }

      parameter {
        name = "Parameters"
        values = ["${local.kms_id}"]
      }
    }
  }
}




resource "aws_ssm_maintenance_window_task" "ctask" {

  count = var.enabled_cloudwatch_task ? 1 : 0
  name = "${var.app_name}-cloudwatch_log"
  max_concurrency = 2
  max_errors = 1
  priority = 2
  service_role_arn = "${aws_iam_role.role.arn}"
  task_arn = "AWS-ConfigureCloudWatch"
  task_type = "RUN_COMMAND"
  window_id = "${aws_ssm_maintenance_window.window.id}"

  targets {
    key = "WindowTargetIds"
    values = ["${aws_ssm_maintenance_window_target.target.id}"]
  }

  task_invocation_parameters {
    run_command_parameters {
      timeout_seconds = 600
      parameter {
        name = "status"
        values = ["Enabled"]
      }

      parameter {
        name = "properties"
        values = [file("${path.module}/AWS.EC2.Windows.CloudWatch.json")]
      }
    }
  }
}


