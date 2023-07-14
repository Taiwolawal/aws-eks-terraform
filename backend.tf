terraform {
  backend "s3" {
    bucket = "eks-s3-prod"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"

    # For State Locking
    dynamodb_table = "eks-dynamo-prod"

  }
}


