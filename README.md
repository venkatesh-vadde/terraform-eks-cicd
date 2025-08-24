🚀 EKS Made Easy: Launch My Simple App in the Aws Cloud!

Deploy your containerized application to a scalable Kubernetes cluster on AWS with fully automated infrastructure and delivery! 

✨ This project demonstrates an end-to-end DevOps pipeline using Terraform for infrastructure provisioning and GitHub Actions for CI/CD.

🏛️ Architecture
The project is designed with a clear separation of concerns to be modular and scalable.

Terraform Backend: Terraform state is stored securely in an S3 bucket with state locking managed by a DynamoDB table. This is a one-time bootstrap process.

AWS Infrastructure: Terraform provisions a custom VPC and a managed EKS cluster to host your application.

Application & Deployment: A Python Flask app is containerized with Docker. A GitHub Actions pipeline automatically builds the Docker image, pushes it to an ECR repository, and deploys it to EKS using kubectl.

🛠️ Prerequisites
Ensure you have the following tools installed and configured:

AWS CLI

Terraform (v1.5.0+)

kubectl

Docker

Git

A GitHub Account with a repository for this project.

⚙️ Setup and Deployment
Follow these steps in order to set up and deploy the project.

1. Bootstrap the Terraform Backend
First, provision the remote state storage on AWS.

Bash

cd backend-setup/
terraform init
terraform apply -var-file="terraform.tfvars"
2. Provision the EKS Cluster
Next, use the remote backend to provision all the core infrastructure.

Bash

cd ../terraform/
terraform init
terraform plan -var-file="vars/dev.tfvars" -out="tfplan.out"
terraform apply "tfplan.out"
3. Configure GitHub Actions
To enable the automated pipeline, set up an IAM role in AWS and update the workflow file.

In the AWS console, create an IAM role with a Web identity trusted entity.

Set the Provider to token.actions.githubusercontent.com and the Audience to sts.amazonaws.com.

Attach the AmazonEKSClusterPolicy, AmazonEKSWorkerNodePolicy, AmazonEC2ContainerRegistryFullAccess, and AmazonEKS_CNI_Policy policies.

Open .github/workflows/ci-cd.yml and replace the placeholder <YOUR_AWS_ACCOUNT_ID> with your AWS account ID.

4. Trigger the Pipeline
Push your code to the main branch. The GitHub Actions pipeline will automatically build and deploy your application to EKS.

Bash

git add .
git commit -m "feat: Initial project setup"
git push origin main
🗑️ Cleanup
To avoid ongoing AWS charges, destroy all resources when you're finished.

From the terraform/ directory:

Bash

terraform destroy -var-file="vars/dev.tfvars"
Then, from the backend-setup/ directory:

Bash

cd ../backend-setup/
terraform destroy --var-file="terraform.tfvars"