
# PoC to check GitHub integration with OpenTofu

GOALS:

- Run opentofu deployment (apply) of AWS resources via GitHub actions

## Prerequisites

### Create IAM Role allowing GitHub to operate in AWS account

1. Browse to `Poc2_github_actions_integration/infra_github_iam_role`
2. Set your repository name in main.tf (var.github_repo)
3. Run init and apply (this will create an IAM role in your account, which later be assumed by github actions):

```
tofu init

tofu apply
```

4. In your github repo set up secrets AWS_ACCOUNT_ID and AWS_REGION with respective values.

The resources created is an IAM Role and attached policies for GitHub Actions integration

## Design OpenTofu code to de deployed

Browse to `Poc2_github_actions_integration`.

You can see artifacts, similar Poc1: 
- `infra` : opentofu code which deploys SSM parameter(s)  
- `deployments/dev2`: tfvars file with custom parameter values

## GitHub Workflow

Refer to `./github/workflows/test_workflow.yaml`.

This workflow:
- Configures AWS credentials (it assumes an IAM role created in prerequisites).
- SetUps OpenTofu
- Initializes backend (tfstate resides on S3)
- Creates apply plan using variables from `dev2`
- Applies created plan
