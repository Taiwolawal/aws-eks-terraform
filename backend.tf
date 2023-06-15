terraform {
  backend "s3" {
    bucket = "my-eks-bucket"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"

    # For State Locking
    dynamodb_table = "dev-eks-dynamo"

  }
}


