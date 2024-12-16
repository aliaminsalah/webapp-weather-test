# WebApp Weather Pipeline Project " Version 1 "
## This project represents Version 1 of automating the deployment of a Python-based weather application using Docker, AWS EC2, Jenkins, and Ansible. Below is a breakdown of the work done, the tools used, and the project flow.

## Key Features
Application: A Python-based weather app, containerized with Docker.
Infrastructure: Two AWS EC2 Ubuntu instances configured to host the application.
Deployment Automation: Ansible manages EC2 configuration, sets up Docker, and deploys the application container.
Prerequisites
## Tools Required:

Git
Docker
AWS CLI
Jenkins
Ansible
## Accounts Required:

GitHub (for repository management)
Docker Hub (for image storage)
AWS Account (for EC2 instances)
## Credentials:

Jenkins credentials with Docker Hub username and token.
AWS credentials configured for the CLI.
## Steps to Setup
## 1. Initial Work on Local Machine
Code Handling:

Received the Python application code from the developer.
Created a Dockerfile to containerize the application.
Stages in Docker (as a description):

Set up a lightweight Python 3.9 base image.
Copied the application code into the container.
Installed the necessary dependencies (using requirements.txt).
Exposed port 5000 for the application.
Defined the command to run the Python application.
Repository Management:

Uploaded the Dockerized application to a private GitHub repository.
## 2. Jenkins Setup
Jenkinsfile:
A Jenkins pipeline was created with the following stages:
Clone the Code: Pull the application code from the private GitHub repository.
Build the Image: Build a Docker image from the Dockerfile.
Push the Image: Push the built Docker image to Docker Hub.
Run the Container: Test the container locally.
Trigger Ansible Playbook: Automate deployment on the EC2 instances.
## 3. AWS EC2 Instances
Setup:
Two Ubuntu instances were created using the AWS Management Console.

Manual SSH Access (Configured locally):
Copied the key file to the SSH directory:

```bash
نسخ الكود
sudo cp -rf /mnt/c/Users/aliam/Downloads/ansible1.pem ~/.ssh/id_ed25519
```

Accessed the instances:

```bash
نسخ الكود
ssh -i /home/ali/.ssh/id_ed25519 ubuntu@54.237.235.118
```
## 4. Ansible Configuration
Inventory File:
Contains details about the EC2 instances, including their IP addresses and the key pair for SSH authentication.

Playbook Tasks:
The playbook automates the following steps:

Updates and upgrades the packages on both EC2 instances.
Installs Docker and Git.
Clones the private GitHub repository on the instances.
Pulls the Docker image from Docker Hub.
Runs the Docker container on both instances.

## Project Flow
Clone the application repository.
Create a Dockerfile to containerize the application (details in the repository).
Push the Docker image to Docker Hub using Jenkins.
Use Ansible to configure the EC2 instances, pull the Docker image, and run the application automatically.
This setup represents a fully automated pipeline where the Python application code is deployed on AWS EC2 instances via containerization. The code and configurations are available in the GitHub repository.

----------------------------------------------------------------------
# WebApp Weather Pipeline Project "Version 2"

This project automates the deployment of a Python-based weather application using Docker, AWS EC2, and Ansible, replacing the Jenkins pipeline with a Bash script for managing the build and deployment process. The setup includes building a Docker image, pushing it to Docker Hub, and deploying it on two Ubuntu EC2 instances.


Prerequisites

## Tools Required:

Git

Docker

Bash script 

AWS CLI

Ansible

## Accounts Required:

GitHub (for repository management)

Docker Hub (for image storage)

AWS Account (for EC2 instances)

## Credentials:

Docker Hub username and token.

AWS credentials configured for the CLI.

## Steps to Setup

1. Bash Script for CI/CD Process

The Bash script automates the following stages:

Building the Docker Image: Creates a Docker image from the provided Dockerfile.

Running the Docker Container: Tests the container locally by running it.

Pushing the Docker Image: Uploads the built image to Docker Hub.

Triggering Ansible Playbook: Executes the playbook for deploying the application on EC2 instances.

2. AWS EC2 Instances

Setup: Two Ubuntu instances are created on AWS to host the application.

Manual SSH Access (Optional for Debugging):

```bash
sudo cp -rf /mnt/c/Users/aliam/Downloads/ansible1.pem ~/.ssh/id_ed25519
ssh -i /home/ali/.ssh/id_ed25519 ubuntu@<INSTANCE_IP>
```

3. Ansible Configuration

Inventory File:
Specifies the EC2 instances with their IP addresses and the key pair for SSH authentication.

Playbook Tasks:
Automates the following steps:

Updates and upgrades the packages on both EC2 instances.

Installs Docker and Git.

Clones the private GitHub repository on the instances.

Pulls the Docker image from Docker Hub.

Runs the Docker container on both instances.

## Project Flow

1- Clone the application repository.

2- Use the Bash script to:

Build the Docker image.

Push the image to Docker Hub.

Test the container locally.

Trigger the Ansible playbook to:

Configure the EC2 instances.

Pull the Docker image.

Run the container on both instances.

3- Activating the Bash Script

To make the Bash script executable and run it:

```bash
chmod +x script.sh
./script.sh
```

This setup eliminates the need for Jenkins by using a Bash script, streamlining the deployment process while maintaining full automation. The code and configurations are available in the GitHub repository.

------------------------------------------------------------------------------------
# WebApp Weather Pipeline Project "Version 3"

This version evolves the pipeline by introducing Terraform for Infrastructure as Code (IaC), replacing manual instance creation and configuration with automated provisioning and setup. The deployment pipeline uses a Bash script to manage Docker image building, testing, pushing, and infrastructure deployment.

## Key Features
- Application:
        The project continues to focus on a Python-based weather application, packaged as a Docker container.

- Infrastructure:
        Terraform provisions two Ubuntu EC2 instances on AWS, configured automatically during creation.

## Automation:

Terraform: Manages AWS infrastructure provisioning, including configuring the instances during creation with a user-data script.
Bash Script: Handles the entire deployment pipeline, including building the Docker image, testing it locally, pushing it to Docker Hub, and triggering Terraform to deploy the infrastructure.
## Project Steps
1. Bash Script for Automation
A Bash script orchestrates the entire CI/CD pipeline. It handles the following stages:

Building the Docker image for the application.
Testing the container locally to ensure functionality.
Pushing the Docker image to Docker Hub.
Running Terraform to provision EC2 instances and deploy the application.
The script ensures a smooth and error-free pipeline by validating each step, such as confirming successful Docker image builds and Terraform execution.

2. Infrastructure Provisioning with Terraform
Terraform is used to automate the creation of two Ubuntu EC2 instances. The instances are provisioned in the specified AWS region with user-data scripts that:

Update the system and install essential tools like Git and Docker.
Configure Docker to run as a service.
Clone the application repository from GitHub.
Pull the Docker image from Docker Hub.
Run the weather application as a containerized service.
This approach eliminates the need for post-creation manual configuration, as all necessary setup is handled during instance creation.

3. User-Data Script for EC2 Configuration
A user-data script is embedded in the Terraform configuration to automate the instance initialization. It ensures that once the EC2 instances are provisioned, they are ready to run the weather application with minimal intervention. The script handles tasks like:

Installing dependencies.
Configuring Docker.
Pulling the pre-built Docker image.
Running the application container.
Workflow Overview
Code Repository:
The project repository contains all necessary files, including the Bash script, Terraform configurations, and Dockerfile.

## Execution:
The Bash script is executed locally to initiate the pipeline. It builds the Docker image, tests it, pushes it to Docker Hub, and invokes Terraform to create and configure the EC2 instances.

## Deployment:
Terraform provisions the EC2 instances, automatically configures them using the user-data script, and runs the application container.

## Outcome:
The weather application is deployed and accessible on the AWS EC2 instances without requiring manual setup.

## Enhancements in Version 3
Terraform Automation:
The manual creation and configuration of EC2 instances are replaced with fully automated provisioning using Terraform, making the process more reliable and repeatable.

Integrated Configuration:
The user-data script ensures that instances are configured and ready to run the application immediately after provisioning.

Unified Pipeline:
The Bash script combines application lifecycle management (Docker build, test, push) with infrastructure deployment, providing a streamlined workflow.

This version significantly improves scalability and reduces the potential for human error by automating both infrastructure and application deployment end-to-end.

---------------
Output File
For comprehensive documentation, an Output file has been added that includes:

All screenshots captured during different stages of the project.
Execution results for each version of the project.
Any additional outputs from the development process.
The file can be accessed under the name: 
## Output_images
-------------
## Acknowledgments
Special thanks to Instructor Ali Ayman for his continuous support and guidance throughout the project.
Additionally, heartfelt gratitude to Dhub and Orange for their contributions.
