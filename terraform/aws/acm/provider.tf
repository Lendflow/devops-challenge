provider "aws" {
  region              = var.region
  allowed_account_ids = [
    "416579879215",
  ]
}
