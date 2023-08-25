output "vpc_id" {
  value = aws_vpc.vpc.id
}


output "subnets" {
  value = aws_subnet.subnet[*]
}

output "subnets_id" {
  value = aws_subnet.subnet[*].id
}

output "public_subnet_id"{
  value = [for index in [for idx, subnet in var.subnet_name_cidr : idx if can(regex("(PUB)", subnet.name))]: aws_subnet.subnet[index].id]
  # value = [for index in [0,1] : aws_subnet.subnet[index].id ]
}

output "private_asg_subnet_id"{
  value = [for index in [for idx, subnet in var.subnet_name_cidr : idx if can(regex("(PRI)", subnet.name)) ]: aws_subnet.subnet[index].id]
  # value = [for index in [2,3] : aws_subnet.subnet[index].id ]
}

output "private_was_subnet_id"{
  value = [for index in [for idx, subnet in var.subnet_name_cidr : idx if can(regex("(WAS)", subnet.name)) ]: aws_subnet.subnet[index].id]
  # value = [for index in [2,3] : aws_subnet.subnet[index].id ]
}


output "private_db_subnet_id"{
  value = [for index in [for idx, subnet in var.subnet_name_cidr : idx if can(regex("(DB)", subnet.name))]: aws_subnet.subnet[index].id]
  # value = [for index in [4,5] : aws_subnet.subnet[index].id ]
}

output "private_subnet_id"{
  value = [for index in [for idx, subnet in var.subnet_name_cidr : idx if can(regex("(PRI)", subnet.name)) || can(regex("(WAS)", subnet.name)) || can(regex("(DB)", subnet.name))]: aws_subnet.subnet[index].id]
  # value = [for index in [2,3,4,5] : aws_subnet.subnet[index].id ]
}

output "lb_subnet_id"{
  value = [for index in [for idx, subnet in var.subnet_name_cidr : idx if can(regex("(PRI3)", subnet.name)) || can(regex("(PRI4)", subnet.name)) || can(regex("(DB)", subnet.name))]: aws_subnet.subnet[index].id]
  # value = [for index in [2,3,4,5] : aws_subnet.subnet[index].id ]
}


# 수동으로 서브넷 봐서 값 넣어주기 + 서브넷 나눌때 public 부터 나누기
output "public_subnet_count"{
  value = length([for idx, subnet in var.subnet_name_cidr : idx if can(regex("(PUB)", subnet.name))])
  # value = 2
}

output "private_subnet_count"{
  value = length([for idx, subnet in var.subnet_name_cidr : idx if can(regex("(PRI)", subnet.name))]) + length([for idx, subnet in var.subnet_name_cidr : idx if can(regex("(WAS)", subnet.name))]) + length([for idx, subnet in var.subnet_name_cidr : idx if can(regex("(DB)", subnet.name))])
  # value = 4
}

output "availability_zone"{
  value = var.availability_zone
}

output "availability_zone_count"{
  value = length(var.availability_zone)
}

output "asg1_subnet_id"{
  value = [for index in [for idx, subnet in var.subnet_name_cidr : idx if can(regex("(PRI3)", subnet.name)) || can(regex("(PRI4)", subnet.name)) || can(regex("(DB)", subnet.name))]: aws_subnet.subnet[index].id]
  # value = [for index in [2,3,4,5] : aws_subnet.subnet[index].id ]
}

output "asg2_subnet_id"{
  value = [for index in [for idx, subnet in var.subnet_name_cidr : idx if can(regex("(PRI5)", subnet.name)) || can(regex("(PRI6)", subnet.name)) || can(regex("(DB)", subnet.name))]: aws_subnet.subnet[index].id]
  # value = [for index in [2,3,4,5] : aws_subnet.subnet[index].id ]
}