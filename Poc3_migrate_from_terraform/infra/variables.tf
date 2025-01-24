
variable "aws_region" {
  default = "eu-central-1"
}

variable "project" {
  default = "tofutest"
}

variable "stage" {
  description = "deployment name"
  default     = "dev"
}

variable "parameter_content" {
  description = "the content for SSM parameter"
}
