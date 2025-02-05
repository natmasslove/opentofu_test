



terraform {
  backend "s3" {
    bucket = "s3-opentofu-test-20250122"
    key    = "${var.stage}/terraform.tfstate"
    region = var.aws_region
  }
}

resource "aws_ssm_parameter" "test_param" {
  name        = "param-${var.project}-simple-${var.stage}"
  description = "test2"
  type        = "String"
  value       = var.parameter_content
}
