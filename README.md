# dri-automation-terraform
Home for the terraform modules that are needed to create AWS infrastructure for automation 

# State store 
The terraform state is stored within an S3 bucket in the management account. Each environment has a state stored 
with its own key, this is achieved using terraform workspaces. That S3 bucket and a dynamodb table to hold locks has 
been manually created first within the AWS management account.  

# Deploying the queue by running terraform module
The deployment to specific environments is managed using terraform workspaces. In DRI we make use of the three 
worksapce (dev / stg / prd) to manage deployments to specific environment. If no workspace is specifically used, 
the default workspace is expected to have same parameters as "dev" 

# Deploying the queue in AWS
It is decided that the terraform configuration will be run locally to deploy the queue into the AWS infrastructure. 
In future, we may decide to have this as a github action, which will affect the following instructions.

* Make sure you have access to the AWS account tna-iam  
* Setup a profile for your own tna-iam role in your `~/.aws/credentials` with a preferred name (e.g. `dri-admin`)
```  
   [dri-admin]   
   aws_access_key_id = <YOUR_ACCESS_KEY_ID_HERE>   
   aws_secret_access_key = <YOUR_SECRET_ACCESS_KEY_HERE>
``` 
* Setup the credentials for 3 profiles, one for each environment with names as `dev-dri-terraform`, `stg-dri-terraform`, 
`prd-dri-terraform` with the details as shown in example below
```
[dev-dri-terraform]
role_arn = arn:aws:iam::<ACCOUNT_ID_OF_ENVIRONMENT>:role/IAM_Admin_Role
source_profile = <NAME_OF_THE_IAM_PROFILE - e.g. dri-admin>
```
* Open a terminal window
* Navigate to the `queue` folder
* Run `terraform workspace list` to see the current workspace and the current workspace in use
* If you intend to provision dev environment and dev workspace does not exist run `terraform workspace new dev`
* Run `terraform plan` to see the plan
* Run `terraform apply` to provision the infrastructure.

