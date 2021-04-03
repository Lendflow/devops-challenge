terraform {
  backend "s3" {
    bucket = "devops-challenge-terraform-state"
    key    = "ec2-nginx"
    region = "us-east-1"
  }
}
