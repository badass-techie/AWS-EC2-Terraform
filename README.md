# AWS-EC2-Terraform

This project demonstrates how to provision a publicly accessible AWS EC2 instance using Terraform.

## Prerequisites

- You need to have an AWS account and an IAM user with sufficient permissions to create and manage EC2 resources.
- You need to have an SSH key pair generated and uploaded to AWS. You can use the following command to generate a key pair:

  ```bash
  ssh-keygen -t rsa -b 4096 -f my_ssh_keypair_name
  ```

  Then, you can use the AWS CLI or the AWS console to upload the public key to AWS.

- You need to have Terraform installed on your machine.

    Windows:

    ```bash
    winget install Hashicorp.Terraform
    ```

    MacOS:

    ```bash
    brew install terraform
    ```

    Linux:

    ```bash
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
    ```

    ```bash
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    ```

    ```bash
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    ```

    ```bash
    sudo apt-get update && sudo apt-get install terraform```
    ```

- You need to have the AWS CLI installed and configured with your AWS credentials. You can follow the instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).

## Instructions

- Clone this repository or download the code as a zip file.

  ```bash
  git clone https://github.com/user/AWS-EC2-Terraform.git
  ```

- Navigate to the project directory and open the `main.tf` file. Replace the value of `key_name` with your SSH key pair name.

  ```terraform
  # Create an EC2 instance
  resource "aws_instance" "my_ec2_instance" {
    ami           = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22.04 Jammy
    instance_type = "t2.micro"              # Instance type
    key_name      = "my_ssh_keypair_name"   # SSH key pair name

    tags = {
      Name = "MyEC2Instance"
    }
  }
  ```

- Initialize Terraform by running the following command:

  ```bash
  terraform init
  ```

  This will download the necessary plugins and modules for the project.

- Apply the Terraform configuration by running the following command:

  ```bash
  terraform apply
  ```

  This will create the EC2 instance, security group, elastic IP, and EBS volume as defined in the `main.tf` file. You will be prompted to confirm the changes before applying them.

- Go to the AWS console and navigate to the EC2 dashboard. You should see the EC2 instance that was created by Terraform.

- Once the apply is complete, you will see the output of the public IP address of your EC2 instance. You can use this IP address to connect to your instance via SSH.

  ```bash
  ssh -i my_ssh_keypair_name ubuntu@<public_ip>
  ```

- To destroy the resources created by Terraform, run the following command:

  ```bash
  terraform destroy
  ```

  This will delete all the resources and free up any charges incurred by them. You will be prompted to confirm the changes before destroying them.

## References

: https://www.terraform.io/downloads.html

: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html