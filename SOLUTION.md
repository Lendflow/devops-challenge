# Solution

This page documents all notes and aspects of the solution to the devops challenge. 

# Requirements

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
- Terraform the nginx ec2 instances zone:
```
cd ./terraform/ec2-nginx
terraform init
terraform apply
```
- Run Ansible to gather the SSH public keys:
```
cd ./ansible
ansible-playbook localhost-aws-ssh-scan.yml -e region=us-east-1
# if AWS System Log is slow to output, you can use the ssh-keyscan method...
ansible-playbook localhost-aws-ssh-scan.yml -e region=us-east-1 -e ssh_keyscan_scrape_method=ssh-keyscan
```
- Run the initial-configuration playbook:
```
ansible-playbook initial-configure.yml
```
- Run the nginx playbok:
```
ansible-playbook lend-nginx-deploy.yml
```
- Run the check script if desired:
```
ansible-playbook lend-nginx-check-and-start.yml
```
- Back to Terraform, deploy ACM, to support TLS:
```
cd ./terraform/acm
terraform init
terraform apply
```
- Now deploy the load balancer:
```
cd ./terraform/lb
terraform init
terraform apply
```

Verify:
```
(virtualenv) ➜  devops-challenge git:(wcawthra/ISSUE-123) ✗ curl https://www.lend.aws.littlefluffyclouds.io
deploy host: lend-nginx-02
deploy date: 2021-04-03T14:43:42Z

(virtualenv) ➜  devops-challenge git:(wcawthra/ISSUE-123) ✗ curl https://www.lend.aws.littlefluffyclouds.io
deploy host: lend-nginx-03
deploy date: 2021-04-03T14:43:42Z
```

## Log and Thought Process

- Off we go, at around 8:31 AM (all times EST) I forked the repo. Created a new branch `wcawthra/ISSUE-123`.
- So I've been thinking a log since I saw the email (7:15 AM) about how I want to approach this. I have a burning desire to address all extra credit issues but that might be time costly. I also think this solution SCREAMS a serverless stack, but that wasn't requested. I think the first step is I'm going to deploy two instances, with an ELB in front. I'm guessing that some of the lead-in to an ELB would request this. This means we can perform maintenance on an instane and still serve our data. It's hugely overkill for the demo, but I'm trying to imagine what problem LendFlow is really looking for me to solve.
- OK, I have a foo-demo AWS account ready for this. so I'm good to go there.
- One risk I know of myself is getting excited at solving a problem before I've truly absorbed the problem. I tend to like to have "feel" the problem and solution vs having it be theoretical.
- Initial design (napkin design in my head) will be S3 bucket (Terraform remote state, no dynamodb state locking in this case), VPC, ELB, 2 ec2 instances... I think that captures it. If I decide to terminate TLS at the instance, I'll also run a codebuild job to use letsencrypt and update the certificates on the instances (advantage: TLS within the VPC, sometimes all traffic must be encrypted, even private VPC traffic), if I decide to terminate at the ELB, it will just be AWS ACM.
- First step, create the `s3-devops-challenge-terrafoorm-state`. This is for Terraform remote state. No DynamoDB setup for locking. Note this state is saved in Git. It's a bit of a chicken and the egg problem, so I'll just step over it here.
- Wanted to talk about `terraform.tfvars` and `varables.tf`. Sometimes, hardcoding variables into the Git project is not desired. Sometimes its fine. In this case, I am going to commit `terraform.tfvars`, but this setup allows flexibility should that ever NOT be desired. Could be a bit overkill and is really workflow/project dependent. Shamme that the backend doesn't take variables.
- Updated `.gitignore`.
- Terraformed remote state.
- Terraformed the Route53 zone. I have the domain `littlefluffyclouds.io`, its a little playground. Domain for this demo is `lend.aws.littlefluffyclouds.io`.
- So, at this point, I want to mention WHY I break up each of these Terraform steps. It would be faster to do them all at once in one big Terraform project. I have found this to be `the bad path`. I prefer to break them up in discrete, logical steps. The remote state, Route53 zone, VPC, they're all unique logical entities and should be seperated. I don't want to wait 10 minutes for a GIGANTIC Terraform project just because I update a tag on an instance. If I really wanted to automate the whole, these individual Terraform projects are a bash script or ansible-playbook away. Left in a vacuum, I would choose to make this decision (additional information may change that decision).
- Actually Terraform destroying the zone, as I decided to use a different domain name.
- Also noticed that the output uses `tolist`. Weird. Never noticed that before. I suspect my other projects use an older version of Terraform.
- Moving on to the VPC.
- Kids awake, stepping away for a second...
- Back at it. Fixing some tags, setting some variables.
- DNS seems updated and working, just verified my test host:
```
(virtualenv) ➜  route53 git:(wcawthra/ISSUE-123) ✗ host test.lend.aws.littlefluffyclouds.io
test.lend.aws.littlefluffyclouds.io has address 10.1.2.3
```
- OK, Terraformed the VPC. I think it's important to touch on a few things here. First, I use a GitHub module for this. If trust and/or stability is an issue, you can fork it or even pull it locally and check it into the repo. I think I'll do that with my instance module, to show a Terraform module using a path on disk. In this case, the module I use for VPC creation, I just LOVE. great naming, lots of variables to do tons of heavy lifting for me.
- And now on to the Terraform module example where we reference a local module path. This particular module I use for a lot of things, so you'll see some unique settings; URL tags, prometheus_node_exporter tags. This is mostly due to how I automate scanning and monitoring of systems. I can explain further if need be.
- OK, I'm going to stop Terraforming and move on to Ansible. Will circle back to Terraforming with ACM and ELB in a bit...
- Ansible time. I use Ansible for everything. If i'm automating something, I try to avoid Bash scripts and stick with Ansible as my harness. It's my workflow.
- Configuring the Ansible inventory. Lots of variables within `./ansible/inventory/aws-lend/group_vars/all`. 
- First things first. Gather the SSH public keys. This can be done by scraping the AWS system log, or basically running `ssh-keyscan` against the instances. I usually avoid the second option, as it should only be done against trusted networks. BUT, sometimes the AWS system log can be slow or just NOT output the SSH key.
```
ansible-playbook localhost-aws-ssh-scan.yml -e region=us-east-1
```
- If you look at the playbook/role, you can see what it does. After running this, I'm able to tab-complete in ZSH something like:
```
ssh -i ~/.ssh/devops-challenge ubuntu@lend-nginx-01-public
```
- Next, we configure the instances. I have a pretty standard playbook I use:
```
ansible-playbook initial-configure.yml
```
- Note this playbook uses the default inventory `./inventory/aws-lend/public_aws_ec2.yml`. This is a dynamic inventory; many cloud providers are supported, this particular yaml file returns the EC2 instances with public IP addresses as the Ansible SSH host.
- Note that all instances I create have two EBS volumes; the root volume and a data volume. I do this because I like to keep it seperate and on Ubuntu, with ext4, if we need a larger disk, I can perform a live resize of the data volume. (RHEL defaults to XFS, where the root FS can be resized live, but on Ubuntu this is not doable by default.)
- This is going a lot slower than I'd like, mostly due to the fact I'm trying to capture a lot of what I'm doing. Hrmph. I was hoping to add a lot of other extra credits. I may cut them out for expediencies sake.
- Now that we have a standard deployment configured, lets go to the NGINX configuration.
- I use a standard `service.nginx` role for reverse proxying, mostly because I often find I create systems that deploy a web service, and I'll configure letsencrypt to expose the web service. This example we will not do that, so we're going to have a custom NGINX role.
```
ansible-playbook lend-nginx-deploy.yml
```
- Custom role deployed. We can verify we're working:
```
(virtualenv) ➜  ansible git:(wcawthra/ISSUE-123) ✗ curl nginx-01.lend.aws.littlefluffyclouds.io
deploy host: lend-nginx-01
deploy date: 2021-04-03T14:43:43Z

(virtualenv) ➜  ansible git:(wcawthra/ISSUE-123) ✗ curl nginx-02.lend.aws.littlefluffyclouds.io
deploy host: lend-nginx-02
deploy date: 2021-04-03T14:43:42Z

(virtualenv) ➜  ansible git:(wcawthra/ISSUE-123) ✗ curl nginx-03.lend.aws.littlefluffyclouds.io
deploy host: lend-nginx-03
deploy date: 2021-04-03T14:43:42Z

```
- Markers are there, which will show the ELB and each instance working acordingly. I'll be able to verify the ELB can talk to each once I set this up.
- Lets also pause and reflect at what I've done. I've used Ansible to deploy an NGINX Docker container that is run by systemd on all instances. It serves content that is rendered to the EBS data volume. Systemd handles the NGINX service, which is just starting/stopping an NGINX container.
- To check if the service is running (and restart if it's not), we can run this playbook:
```
ansible-playbook lend-nginx-check-and-start.yml
```
- That basically ssh's to the instance, ensures the service is started, checks port 80 to see if it's running, if it's not, restart the service.
- OK, now to get this ELB setup...
- First Terraform the ACM. Going to terminate the TLS at the ELB layer.
- Check. Now to configure the LB.
- OK, this was super fun. Had to fight with providing multiple attachments to the load balancer. Was a bit of an adventure debugging. Eventually the `data.aws_instances` reference gave me the very exact example I needed - <https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/instances>.
- Using some defaults for the health check, probably a bit long, but just going to go with it (3, 3, 30 seconds).
- With this finally deployed, we can now curl the TLS load balancer.
```
(virtualenv) ➜  devops-challenge git:(wcawthra/ISSUE-123) ✗ curl https://www.lend.aws.littlefluffyclouds.io
deploy host: lend-nginx-02
deploy date: 2021-04-03T14:43:42Z

(virtualenv) ➜  devops-challenge git:(wcawthra/ISSUE-123) ✗ curl https://www.lend.aws.littlefluffyclouds.io
deploy host: lend-nginx-03
deploy date: 2021-04-03T14:43:42Z

```

# Parting Thoughts

With that, I'm wrapping it up. Would have loved to deployed a serverless version, but time is a bit against me. I'd also say, this deployment could be transposed to Google Cloud or Azure. We would have to create some new Terraform modules, but the Ansible code should be mostly untouched. I've done similar deployments to BOTH Google Cloud and Azure.

Also, full disclose, much of this code I reuse on a constant basis. I've used this on many different projects throughout the course of my career. I'm not sure if you care, but it wasn't all written from scratch. I've done many similar examples (everything is always slightly customized though, right?). The only thing I wasn't super familiar with, because I haven't really had to do it, was the LB Terraform config. Wasn't a huge deal, just was something a bit more fresh.

More than happy to discuss any and all aspects of it, why I chose XYZ, etc etc.

Thank you for your time!


# Random AWS SSM Commands

- Put parameters
```
aws ssm put-parameter --name "/ansible/public-key" --type "SecureString" --value "$(cat ~/.ssh/devops-challenge.pub)"
aws ssm put-parameter --name "/ansible/private-key" --type "SecureString" --value "$(cat ~/.ssh/devops-challenge)"
