# AWS EKS KUBERNETES SETUP USING TERRAFORM

In this project, we will be setting up an EKS cluster using terraform modules. We need to ensure we have certain things in place.
- Install Terraform on the local machine. I used v1.5.O for this project
- Install aws-cli to be able to communicate with AWS. I used aws-cli/2.8.1 version
- Install kubectl v1.26

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

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/1c9250d7-3f26-47de-a256-10f719ba62c5)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/891b1ead-58bc-4cb5-a9ce-2c2d420d68bc)

Now we should try to communicate with our eks cluster

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/046ea235-18fc-45d7-b71a-c1cd9ab9a185)

We have a working cluster, so we can deploy a container to the cluster

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/e4cbbd14-c2a6-4fe7-bd46-984950b77c1f)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/deef9334-3e85-4028-9ebc-922c04dd255a)

Our containers are deployed properly, hence let's see it on our browser

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/e38a5464-1bb1-4091-878a-c2fa57be1d0d)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/2b694276-2387-4491-8c01-1571e8e700bc)

Now, let's use argocd to see the applications we deployed. We need to install argocd

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/a80e0742-33db-45be-b12a-869ff5b16776)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/92a042c7-a7ea-4a8c-a070-f392784aa417)

We need to get the password, we will use to login into argocd ui.

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/160362e4-8c0b-47e3-8c23-d6b363fa3f20)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/64b13579-25ca-4ee6-8149-f791e9de27ff)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/c14e5de4-20c6-4f35-a617-aaef7055ab5e)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/174c2005-b2ba-4893-8efe-ba71899e9f5e)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/d53c65bb-16dd-47b1-9bdb-10b6f92af960)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/69206033-076e-4cbd-86c0-5d69826358db)

![image](https://github.com/Taiwolawal/aws-eks-terraform/assets/50557587/76e3266d-d5b3-402c-ba64-e5c5d8bbdb6a)
