# Create file1: createInstance.tf
resource "aws_instance" "my-first-aws-instance" {
  ami           = "ami-0db245b76e5c21ca1"
  instance_type = "t2.micro"
  #count = 3

  tags = {
    Name = "demoInstance"
  }
  security_groups = "${var.Security_Group}"
}

# Create file2: provider.tf
provider "aws" {
    access_key = "${var.AWS_ACCESS_KEY}"
    secret_key = "${var.AWS_SECRET_KEY}"
    region = "${var.AWS_REGION}"
}

# Create file3: variables.tf
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "us-west-2"
}
variable "Security_Group" {
    type = list
    default = ["sg-247689oi", "sg-09876567oi", "sg-12345678"]
}

# Create file4: terraform.tfvars
# ensure this file is added to git.ignore and not sync to git repo.
AWS_ACCESS_KEY="enter_access_key_here"
AWS_SECRET_KEY="enter_secret_key_here"
