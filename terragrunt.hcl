# This now looks for a variable called "aws_region" from the child
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
}
EOF
}

# We pull the region from the child's inputs
locals {
  # This finds the 'aws_region' defined in the child's 'inputs' block
  aws_region = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl")).inputs.aws_region
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "my-terraform-state-${get_aws_account_id()}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region # The state bucket region matches the env region
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}
