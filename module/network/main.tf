resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  # name = var.vpc_name1 --> infra vpc
  tags ={
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet" {
  count = length(var.subnet_name_cidr)
  cidr_block = var.subnet_name_cidr[count.index].cidr
  vpc_id = aws_vpc.vpc.id
  
  availability_zone = var.availability_zone[count.index%length(var.availability_zone)]

  tags = {
    Name = var.subnet_name_cidr[count.index].name
  }

  
}
