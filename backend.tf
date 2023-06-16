terraform {
  backend "s3" {
    bucket = "my-eks-s3-project"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"

    # For State Locking
    dynamodb_table = "dev-eks-dynamo"

  }
}


