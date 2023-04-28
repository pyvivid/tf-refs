# vars using lists and maps
# Create file1: createInstance.tf
resource "aws_instance" "my-first-aws-instance" {
  ami           = lookup(var.AMIS,var.AWS_REGION)
  instance_type = "t2.micro"
  #count = 3

  tags = {
    Name = "demoInstance"
  }
  #security_groups = "${var.Security_Group}"
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
#variable "Security_Group" {
#    type = list
#    default = ["sg-247689oi", "sg-09876567oi", "sg-12345678"]
#}

variable "AMIS" {
    type = map
    default = {
        us-east-1 = "ami-091b1c4aa02ba6400"
        us-east-2 = "ami-06903c13b782a7c8c"
        us-west-1 = "ami-07c559a3f0a29c8d5"
        us-west-2 = "ami-01d4b5043e089efa9"
    }

}

# Create file4: terraform.tfvars
# ensure this file is added to git.ignore and not sync to git repo.
AWS_ACCESS_KEY="enter_access_key_here"
AWS_SECRET_KEY="enter_secret_key_here"

# Create file5: backend.tf
terraform {
    backend "s3" {
        bucket = "s3_bucket_name" # Create bucket in AWS first
        key    = "development/terraform_state"
        region = "us-west-2"
    }
}

### Note: tf server needs to be AWS configured ###
