# instance-public instance profile
resource "aws_iam_instance_profile" "instance-public" {
  name = "${var.env}-${var.name}-profile"
  role = aws_iam_role.instance-public.name
}

# instance-public IAM role
resource "aws_iam_role" "instance-public" {
  name               = "${var.env}-${var.name}-profile"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "custom" {
  count      = var.instance_policy_arn == "" ? 0 : 1
  role       = aws_iam_role.instance-public.name
  policy_arn = var.instance_policy_arn
}

