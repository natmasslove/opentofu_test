
# PoC to check OpenTofu capabilities to multiple env with no code duplication

This PoC checks the feature of using vars in backend definition (introduced in OpenTofu 1.8.0).

GOAL:

- To have a single ".tf" codebase
- Perform deployments to different envs just changing "env" variable value

## Setup

1. Created simple TF code to deploy one SSM Parameter
2. Created an S3 bucket to store tfstate files (envs should have different object prefixes in the same bucket).

```bash
aws s3 mb s3://s3-opentofu-test-20250122
```

3. Backend definition 

```hcl
terraform {
  backend "s3" {
    bucket = "s3-opentofu-test-20250122"
    key    = "${var.stage}/terraform.tfstate"
    region = var.aws_region
  }
}
```

4. Created several terraform.tfvars files in subfolders in `deployments` folder (one per env)

## Deployment

### Dev 

Browse to `Poc1_multi-env-deploy\infra`.

1. Init
   
```bash
tofu init -var-file="../deployments/dev/terraform.tfvars" -reconfigure
```

2. Deploy

```bash
tofu apply -var-file="../deployments/dev/terraform.tfvars"
```

### Moving to PROD

```bash
tofu init -var-file="../deployments/prod/terraform.tfvars" -reconfigure
```

2. Deploy

```bash
tofu apply -var-file="../deployments/prod/terraform.tfvars"
```

### Deploy to one more env

```bash
tofu init -var-file="../deployments/client1/terraform.tfvars" -reconfigure
```

2. Deploy

```bash
tofu apply -var-file="../deployments/client1/terraform.tfvars"
```