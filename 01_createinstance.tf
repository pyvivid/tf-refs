# The provider's related codes must be first setup by tf
# to interact with the Cloud Provider.

provider "aws"{
    version = "4.64.0"
    region = "us-west-2"
    access_key = "Enter_UR_Access_Key_Here"
    secret_key = "Enter_your_secret_key_here"
}

resource "aws_instance" "my-first-aws-instance" {
    ami = "ami-0db245b76e5c21ca1" # Replace AMI according to the region and AZ in which you are deploying
    instance_type = "t2.micro"
}
