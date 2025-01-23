
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

```