//environment specific changes are managed here.
locals {
  env = {
    default = {
      env_name     = "dev"
      profile_name = "dev-dri-terraform"
    }

    dev = {
      env_name     = "dev"
      profile_name = "dev-dri-terraform"
    }

    stg = {
      env_name     = "stg"
      profile_name = "stg-dri-terraform"
    }

    prd = {
      env_name     = "prd"
      profile_name = "prd-dri-terraform"
    }
  }

  environmentvars = contains(keys(local.env), terraform.workspace) ? terraform.workspace : "default"
  workspace       = merge(local.env["default"], local.env[local.environmentvars])
}