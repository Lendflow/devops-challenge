terraform {
  backend "s3" {
    bucket = "devops-challenge-terraform-state"
    key    = "acm"
    region = "us-east-1"
  }
}
