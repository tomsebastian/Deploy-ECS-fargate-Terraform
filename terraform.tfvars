aws_profile="default"
aws_region="us-east-1"
account_id="862567339542"

stack="test-ecs-terraform" #project name
environment="testing"
billing_id="test-bill" #tag for billing purpose

vpc_cidr="10.1.0.0/16"

source_repo_branch="main"


#iam_policy_arn= ["arn:aws:iam::aws:policy/${var.stack}-codebuild-policy", "arn:aws:iam::aws:policy/${var.stack}-ecr-policy"]