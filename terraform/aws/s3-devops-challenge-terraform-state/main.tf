resource "aws_s3_bucket" "terraform-state" {
  bucket = "devops-challenge-terraform-state"
  acl    = "private"
  tags = {
    Terraform   = "true"
    Environment = var.env
    Github      = var.github
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "terraform-state" {
  bucket = aws_s3_bucket.terraform-state.id

  block_public_acls   = true
  block_public_policy = true
}

