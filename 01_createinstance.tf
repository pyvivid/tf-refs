provider "aws"{
    version = "4.64.0"
    region = "us-west-2"
    access_key = AKIA35XN7SLMWAEPLLUA
    secret_ket = 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
}

resource "aws_instance" "my-first-aws-instance" {
    ami = "ami-0db245b76e5c21ca1"
    instance_type = "t2.micro"
}
