resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = var.route_vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id = var.route_table_private_nat_gateway_id[count.index]
  }

tags = {
    Name = "CGV-PRD-PRI-RT${count.index+1}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_all_subnets_id)
  subnet_id      = var.private_all_subnets_id[count.index]
  route_table_id = aws_route_table.private[count.index%var.az_count].id
}

resource "aws_route_table" "public" {
  count  = var.az_count
  vpc_id = var.route_vpc_id

  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = var.route_table_public_gateway_id
  }

  tags = {
    Name = "CGV-PRD-PUB-RT${count.index+1}"
  }
}

resource "aws_route_table_association" "public" {
  count  = length(var.public_all_subnets_id)
  # subnet_id      = aws_subnet.TFC_PRD_sub[local.public_subnets[floor(count.index / 1)].subnets[count.index % 1]].id
  subnet_id      = var.public_all_subnets_id[count.index]
  route_table_id = aws_route_table.public[count.index%var.az_count].id
}