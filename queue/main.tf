terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "dri-terraform-state-store"
    key     = "terraform.tfstate"
    region  = "eu-west-2"
    dynamodb_table = "dri-terraform-state-lock"
    encrypt = true
    profile = "dri-terraform"
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

resource "aws_sqs_queue" "terraform_queue" {
  name                      = var.queue_name
  delay_seconds             = var.delay < 90 ? var.delay : 90
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds

  tags = {
    Environment = "dev"
  }
}

data "aws_ssm_parameter" "tre_account_id" {
  name = "TRE-ACCOUNT-ID"
}

data "aws_ssm_parameter" "tre_sns_topic" {
  name = "TRE-SNS-TOPIC"
}

data "aws_ssm_parameter" "tf_state_bucket_name" {
  name = "TF-STATE-BUCKET"
}

resource "aws_sqs_queue_policy" "allow_message" {
  queue_url = aws_sqs_queue.terraform_queue.url
  policy    = templatefile("./templates/sqs_policy.json.tpl", { sqs_arn = aws_sqs_queue.terraform_queue.arn, sns_topic = "arn:aws:sns:${var.region}:${data.aws_ssm_parameter.tre_account_id.value}:${data.aws_ssm_parameter.tre_sns_topic.value}" })
}

