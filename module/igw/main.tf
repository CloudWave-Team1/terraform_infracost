resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.igw_vpc_id

  # tags = var.igw_tags
  tags = {
    Name = var.igw_name
  }
}

 