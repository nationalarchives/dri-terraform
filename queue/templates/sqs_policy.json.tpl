{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${sqs_arn}",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "${sns_topic}"
        }
      }
    }
  ]
}
