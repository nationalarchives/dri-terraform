variable "region" {
  description = "SQS region"
  default     = "eu-west-2"
}

variable "queue_name" {
  description = "Name of the queue, this is used in naming the ARN"
  default     = "dri-tre-notification-receiver"
}

variable "profile" {
  description = "The profile used by terraform to provision the resource"
  default     = "dev-dri-terraform"
}

variable "delay" {
  default = 60
}

variable "max_message_size" {
  default = 2048
}

variable "message_retention_seconds" {
  default = 86400
}

variable "receive_wait_time_seconds" {
  default = 10
}
