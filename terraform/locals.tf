locals {
  default_tags = {
    Repository  = var.code_repo
    Team        = var.team
    Automation  = "terraform"
    Environment = terraform.workspace
  }
  environment = terraform.workspace
  prefix      = "${var.org_name}-${local.environment}-cloud-hiring"
}
