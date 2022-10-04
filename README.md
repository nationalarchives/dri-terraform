# dri-automation-terraform
Home for the terraform modules that are needed to create AWS infrastructure for automation 

# State store 
The terraform state is stored within an S3 bucket. That S3 bucket and a dynamodb table to hold locks has 
been manually created first within the AWS account. If the queue is moved to another account at some point,
it will be necessary to create terraform state store S3 bucket and the dynamodb table for holding lock 

# Deploying the queue in AWS
It is decided that the terraform configuration will be run locally to deploy the queue into the AWS infrastructure. 
In future, we may decide to have this as a github action.

* Make sure you have access to the AWS account where this is being deployed 
* There is an AWS profile called "dri-terraform" which is used to deploy the queue
* Setup the credentials for `dri-terraform` in your `~/.aws/credentials` file
* Open a terminal window
* Navigate to the `queue` folder 
* Run the terraform command to deploy the queue to the AWS infrastructure.

