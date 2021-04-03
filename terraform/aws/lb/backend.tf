terraform {
  backend "s3" {
    bucket = "devops-challenge-terraform-state"
    key    = "lb"
    region = "us-east-1"
  }
}
