# Lendflow Devops Assessment

# Goal

Create a script to deploy a webserver with a script to check that it is running. 

# Prerequisites

You will need an AWS account. Create one if you don't own one already. You can use free-tier resources for this test.

# The Task

You are required to set up a new EC2 instance in AWS. It must:

* Be publicly accessible.
* Run Nginx.
* Deploy the content. This can be as simple as a some static text representing a version number like `4.3.2` or as complex as a full website. You choose. We will not provide the content. 

# Mandatory Work


* Fork this repository.
* Provide instructions on how to create the server
* Provide instructions on deploying the content
* Provide a script that can be run periodically to check if the server is up and serving the expected content 
* Alter the README to contain the steps required to:
  * Create the server.
  * Deploy the content.
  * Run the checker script.
* Provide us IAM credentials to login to the AWS account. If you have other resources in it make sure we can only access what is related to this test.
* Automate as much as possible.
* Document each step. 
* Make it easy to install

Give us access to your fork, and send us an email when you’re done. Feel free to ask questions if anything is unclear, confusing, or just plain missing.

# Extra Credit

We know time is precious, we won't mark you down for not doing the extra credits, but if you want to give them a go...

* Put the server behind a load balancer. Automate this if possible using any tools you are familiar with and document what is going on
* Make the checker script SSH into the instance, check if Nginx is running and start it if it isn't.
* Run Nginx inside a Docker container
* Make it Cloud provider agnostic - i.e. can we repeat this in Azure or Google Cloud Platform

# Questions

#### What scripting languages can I use?

Anyone you like. You’ll have to justify your decision. Please pick something you're familiar with, as you'll need to be able to discuss it.

#### Will I have to pay for the AWS charges?

No. You are expected to use free-tier resources only and not generate any charges. Please remember to delete your resources once the review process is over so you are not charged by AWS.

#### What will you be grading me on?

Scripting skills, elegance, maintainability, understanding of the technologies you use, security, and in case you missed it....documentation!

We don’t want to know if you can do exactly as asked (or everybody would have the same result). We want to know what you bring to the table when working on a project, and how you innovate to make processes better. More features? Best solution? Thinking outside the box?

Hint: we would like to be able to test this outside of the environment you create, so make it reusable

#### Will I have a chance to explain my choices?

Feel free to comment your code, or ideally put explanations in a pull request within the repo in one or more readme files
We’ll discuss the choices you made on the next interview, if applicable.

#### Why doesn't the test include X?

Good question. Feel free to tell us how to make the test better. Or, you know, fork it and improve it!

#### How long should this take?

There are many ways to solve this problem so it may vary for each candidate and depends how far you want to take it but we are confident the basic requirements can be met with 2-3 hours work.
