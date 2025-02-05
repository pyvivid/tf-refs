terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=4, <=5.1"
    }
  }
  backend "s3" {
    bucket              = "tf-backend-020252025"
    key                 = "dev/terraform.state"
    region              = "us-west-2"
    dynamodb_table      = "tf-dev-state-table-appName"
  }
  
}

provider "aws" {
  region = "us-west-2"  # Replace with your preferred AWS region
}

resource "aws_instance" "ubuntu_instance" {
  count           = 3
  ami             = "ami-0606dd43116f5ed57"  # Replace with the latest Ubuntu AMI ID for your region
  instance_type   = "t3.micro"               # Adjust instance type as needed
  key_name        = "aws-oregon-kp1"      # Replace with your SSH key name
  #availability_zone = "us-west-2a"           # You can change the availability zone if necessary


  # EBS Volume Configuration
  root_block_device {
    volume_size = 12    # Size of the root volume in GB
    volume_type = "gp2" # General Purpose SSD (you can adjust based on needs)
  }

  # Optional: Set a name for the instance
  tags = {
    Name = "Ubuntu-EC2-Instance-${count.index + 1}"
  }

  # Optional: Configure security group if needed
  security_groups = ["default"]  # Or your custom security group name
}

output "instance_ids" {
  value = [for i in aws_instance.ubuntu_instance : i.id]  # Corrected output for instance IDs
}

output "public_ips" {
  value = [for i in aws_instance.ubuntu_instance : i.public_ip]  # Corrected output for public IPs
}
