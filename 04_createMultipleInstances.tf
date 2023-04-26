resource "aws_instance" "my-first-aws-instance" {
    ami = "ami-0db245b76e5c21ca1"
    instance_type = "t2.micro"
    count = 3
}
