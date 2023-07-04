# AWS EKS KUBERNETES SETUP USING TERRAFORM

In this project, we will be setting up an EKS cluster using terraform modules. We need to ensure we have certain things in place.
- Install Terraform on the local machine. I used v1.5.O for this project
- Install aws-cli to be able to communicate with AWS. I used aws-cli/2.8.1 version

We need to define AWS terraform provider and the backend where our statefiles will be stored. Please ensure you create the s3 bucket used for the backend before executing the project. It is expected that the s3 bucket already exists.

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/96a55b6e-ec7f-4560-8615-b2f048ec2c7a)
