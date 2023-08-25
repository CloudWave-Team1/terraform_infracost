resource "aws_eip" "subnet_eip" {
  count = var.nat_gateway_count
}



# NAT 게이트웨이 생성
resource "aws_nat_gateway" "nat_gateway" {
  count         = var.nat_gateway_count
  allocation_id = aws_eip.subnet_eip[count.index].id
  subnet_id     = var.nat_gateway_subnet_id[count.index]
  tags = {
    # Name = "TFC-PRD-NAT-${count.index+1}"
    Name = "${var.nat_gateway_name}-${count.index+1}"
  }
}