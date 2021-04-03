# Solution

This page documents all notes and aspects of the solution to the devops challenge.

## Requirements

- AWS CLI. Version 1.19.24 was used, botocore version `1.20.24`
- Terraform. Version `0.14.9` was used.
- Ansible. Version `2.10.2` was used.
- AWS IAM credentials.
- SSH keys for the instance. The default `ubuntu` user is used, the SSH keys can be found in AWS SSM:
```
aws ssm get-parameter --name "/ansible/public-key" --with-decryption | jq -r '.Parameter.Value'
aws ssm get-parameter --name "/ansible/private-key" --with-decryption | jq -r '.Parameter.Value'
```

# Deploy Process

- Verify AWS credentials:
```
aws sts get-caller-identity --query 'Account' --output text
416579879215
```
- Terraform remote state:
```
cd ./terraform/s3-devops-challenge-terraform-state
terraform init
terraform apply
```
- Terraform the Route53 zone:
```
cd ./terraform/route53
terraform init
terraform apply
```

## Log and Thought Process

- Off we go, at around 8:31 AM (all times EST) I forked the repo. Created a new branch `wcawthra/ISSUE-123`.
- So I've been thinking a log since I saw the email (7:15 AM) about how I want to approach this. I have a burning desire to address all extra credit issues but that might be time costly. I also think this solution SCREAMS a serverless stack, but that wasn't requested. I think the first step is I'm going to deploy two instances, with an ELB in front. I'm guessing that some of the lead-in to an ELB would request this. This means we can perform maintenance on an instane and still serve our data. It's hugely overkill for the demo, but I'm trying to imagine what problem LendFlow is really looking for me to solve.
- OK, I have a foo-demo AWS account ready for this. so I'm good to go there.
- One risk I know of myself is getting excited at solving a problem before I've truly absorbed the problem. I tend to like to have "feel" the problem and solution vs having it be theoretical.
- Initial design (napkin design in my head) will be S3 bucket (Terraform remote state, no dynamodb state locking in this case), VPC, ELB, 2 ec2 instances... I think that captures it. If I decide to terminate TLS at the instance, I'll also run a codebuild job to use letsencrypt and update the certificates on the instances (advantage: TLS within the VPC, sometimes all traffic must be encrypted, even private VPC traffic), if I decide to terminate at the ELB, it will just be AWS ACM.
- First step, create the `s3-devops-challenge-terraform-state`. This is for Terraform remote state. No DynamoDB setup for locking. Note this state is saved in Git. It's a bit of a chicken and the egg problem, so I'll just step over it here.
- Updated `.gitignore`.
- Terraformed remote state.
- Terraformed the Route53 zone. I have the domain `littlefluffyclouds.io`, its a little playground. Domain for this demo is `lend.aws.littlefluffyclouds.io`.
- So, at this point, I want to mention WHY I break up each of these Terraform steps. It would be faster to do them all at once in one big Terraform project. I have found this to be `the bad path`. I prefer to break them up in discrete, logical steps. The remote state, Route53 zone, VPC, they're all unique logical entities and should be seperated. I don't want to wait 10 minutes for a GIGANTIC Terraform project just because I update a tag on an instance. If I really wanted to automate the whole, these individual Terraform projects are a bash script or ansible-playbook away. Left in a vacuum, I would choose to make this decision (additional information may change that decision).
- Actually Terraform destroying the zone, as I decided to use a different domain name


# Random AWS SSM Commands

- Put parameters
```
aws ssm put-parameter --name "/ansible/public-key" --type "SecureString" --value "$(cat ~/.ssh/devops-challenge.pub)"
aws ssm put-parameter --name "/ansible/private-key" --type "SecureString" --value "$(cat ~/.ssh/devops-challenge)"
