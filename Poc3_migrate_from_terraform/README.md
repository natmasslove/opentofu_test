
# PoC to check how migration is done from existing terraform infra to OpenTofu

OpenTofu guide for migration: [LINK](https://opentofu.org/docs/intro/migration/terraform-1.8/)

Steps:

## Create infra using Terraform (using s3 backend)

1. Browse to `Poc3_migrate_from_terraform/infra`
2. Initialize terraform

Rename `main.tf_ver1` to `main.tf` (it represents initial TF code with non-dynamic backend)

```bash
terraform init
```

1. Apply changes

```bash
terraform apply -var-file="../deployments/dev3/terraform.tfvars"
```

4. Verify & Backup tfstate.

- Verify changes using AWS console (check the SSM parameter was successfully created).
- BackUp terraform state (download terraform.state) from S3: `s3-opentofu-test-20250122/dev3_tf/` (replace with your bucket name).

5. Migrate to OpenTofu.

in the same folder `Poc3_migrate_from_terraform/infra` run:

```bash
tofu init -upgrade -var-file="../deployments/dev3/terraform.tfvars"
```

```bash
tofu plan -var-file="../deployments/dev3/terraform.tfvars"
```

the plan shouldn't produce any expected changes.

7. Make Changes to infra in order to verify OpenTofu operates well

Change parameter_content variable value in `deployments/dev3`.
Run: 

```bash
tofu apply -var-file="../deployments/dev3/terraform.tfvars"
```

Verify changes were applied correctly.

8. Change s3 backend to a dynamic one (also dynamic region)

Rename `main.tf_ver2` to `main.tf` (it represents initial dynamic backend OpenTofu code).
Now we need to re-initialize tofu backend (using -reconfigure option).

```bash
tofu init -var-file="../deployments/dev3/terraform.tfvars" -reconfigure
```