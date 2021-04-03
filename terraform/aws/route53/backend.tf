terraform {
  backend "s3" {
    bucket = "devops-challenge-terraform-state"
    key    = "route53"
    region = "us-east-1"
  }
}
