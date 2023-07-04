# AWS EKS KUBERNETES SETUP USING TERRAFORM

In this project, we will be setting up an EKS cluster using terraform modules. We need to ensure we have certain things in place.
- Install Terraform on the local machine. I used v1.5.O for this project
- Install aws-cli to be able to communicate with AWS. I used aws-cli/2.8.1 version

We need to define AWS terraform provider and the backend where our statefiles will be stored. Please ensure you create the s3 bucket used for the backend before executing the project. It is expected that the s3 bucket already exists.

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/96a55b6e-ec7f-4560-8615-b2f048ec2c7a)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/12f75bfd-55d0-4e64-b9d9-f5ed4b5a3a89)

To set up the cluster we need to ensure we create a VPC from scratch which our EKS cluster will use to deploy our worker nodes. We will be making use of modules to set up VPC and EKS clusters respectively.

**VPC**
![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/c2054487-e6b2-480b-a8b8-4ca2c9af17f3)


![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/c73991ce-1407-4af6-91c6-a61e1f099c3f)
