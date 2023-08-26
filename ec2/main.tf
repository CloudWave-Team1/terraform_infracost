resource "aws_instance" "example" {
  ami           = "ami-05634c6f3241a48d8"  # Amazon Linux 2 AMI ID
  instance_type = "c5.large"

  tags = {
    Name = "test_infracost"
  }
}
