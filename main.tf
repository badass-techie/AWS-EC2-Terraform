# Specify the provider and region
provider "aws" {
  region = "us-east-1"
}

# Create an EC2 instance
resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22.04 Jammy
  instance_type = "t2.micro"              # Instance type
  key_name      = "ethsafari2023"         # SSH key pair name

  tags = {
    Name = "MyEC2Instance"
  }
}

# Create a security group with an inbound rule to allow all traffic (WARN: for demo purposes only)
resource "aws_security_group" "my_security_group" {
  name        = "MySecurityGroup"
  description = "Security group for MyEC2Instance"

  ingress {
    from_port   = 0    # From port 0
    to_port     = 0    # To port 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"] # From all IP addresses
  }
}

# Assign an Elastic IP to the EC2 instance
resource "aws_eip" "my_eip" {
  domain   = "vpc"                           # For VPC
  instance = aws_instance.my_ec2_instance.id # Associate with MyEC2Instance

  tags = {
    Name = "MyEIP"
  }
}

# Create an EBS volume in the same availability zone as the EC2 instance
resource "aws_ebs_volume" "my_ebs_volume" {
  availability_zone = aws_instance.my_ec2_instance.availability_zone # Same as MyEC2Instance
  size              = 8                                              # Size in GB

  tags = {
    Name = "MyEBSVolume"
  }
}

# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "my_ebs_attachment" {
  device_name = "/dev/sdh"                      # Device name to expose to the instance
  volume_id   = aws_ebs_volume.my_ebs_volume.id # ID of MyEBSVolume
  instance_id = aws_instance.my_ec2_instance.id # ID of MyEC2Instance
}
