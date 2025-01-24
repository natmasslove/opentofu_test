
terraform {
  backend "s3" {
    bucket = "s3-opentofu-test-20250122"
    key    = "dev3_tf/terraform.tfstate"
    region = "eu-central-1"
  }
}

resource "aws_ssm_parameter" "test_param" {
  name        = "param-${var.project}-simple-${var.stage}"
  description = "test2"
  type        = "String"
  value       = var.parameter_content
}
