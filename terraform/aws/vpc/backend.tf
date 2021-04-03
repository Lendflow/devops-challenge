terraform {
  backend "s3" {
    bucket = "devops-challenge-terraform-state"
    key    = "vpc"
    region = "us-east-1"
  }
}
