# AWS EKS KUBERNETES SETUP USING TERRAFORM

In this project, we will be setting up an EKS cluster using terraform modules. We need to ensure we have certain things in place.
- Install Terraform on the local machine. I used v1.5.O for this project
- Install aws-cli to be able to communicate with AWS. I used aws-cli/2.8.1 version

We need to define AWS terraform provider and the backend where our statefiles will be stored. Please ensure you create the s3 bucket used for the backend before executing the project. It is expected that the s3 bucket already exists.

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/96a55b6e-ec7f-4560-8615-b2f048ec2c7a)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/12f75bfd-55d0-4e64-b9d9-f5ed4b5a3a89)

To set up the cluster we need to ensure we create a VPC from scratch which our EKS cluster will use to deploy our worker nodes. We will be making use of modules to set up VPC and EKS clusters respectively.

##VPC

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/c2054487-e6b2-480b-a8b8-4ca2c9af17f3)

##EKS

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/c73991ce-1407-4af6-91c6-a61e1f099c3f)

The value for our variables are

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/88e4dc70-6055-4f8a-a2a1-0fbda1d8596f)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/72ac0032-d6d9-4240-bcea-f5fdef395e2b)

Run `terraform init` to initialize the backend and the modules used for this project

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/e57f9147-6191-457b-9fe2-cb4e258b8e84)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/6b8fe353-9807-4e62-9146-0b6377cc06c9)

I had to resolve a blocker when I tried running `terraform apply`

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/81baf3c7-d02e-4827-a8df-3cee21bb8ebf)

I got an error stating an invalid function argument for node-groups, I had to change the eks version to `18.29.0` to rectify the issue.
To confirm all our resources got provisioned as planned.
