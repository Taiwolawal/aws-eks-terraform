terraform {
  backend "s3" {
    bucket         = "s3-eks-proj"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
 
    # For State Locking
    dynamodb_table = "dev-eks-dynamo"
    
  }
}


