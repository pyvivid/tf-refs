resource "aws_instance" "my-first-aws-instance" {
    ami = "ami-0db245b76e5c21ca1"
    instance_type = "t2.micro"
    count = 3

    tags = {
        # Below will create 3 instances, each with unique names
        Name = "demoInstance-${count.index}"
    }
}
