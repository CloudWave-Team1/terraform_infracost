# data "aws_ami" "amazon_linux_2" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "Name"
#     values = ["Amazon Linux 2 AMI (HVM)*"]
#   }
# }

module "vpc" {
    source = "../../module/network"
    vpc_cidr = var.vpc_cidr
    vpc_name = var.vpc_name

    subnet_name_cidr = var.subnet_name_cidr
    availability_zone = var.availability_zone

}

module "igw"{
  source    = "../../module/igw"
  igw_vpc_id = module.vpc.vpc_id
  depends_on = [module.vpc]
  igw_name = var.igw_name
  # igw_tags = "TFC-${var.env}-IGW"
}

module "nat" {
  source    = "../../module/nat"
  nat_gateway_name = var.nat_gateway_name
  nat_gateway_subnet_id = module.vpc.subnets_id
  nat_gateway_count = module.vpc.public_subnet_count
  depends_on = [module.vpc, module.igw]
   

}

module "route" {
  source = "../../module/route"

  az_count = module.vpc.public_subnet_count
  private_all_subnets_id = module.vpc.private_subnet_id
  public_all_subnets_id = module.vpc.public_subnet_id
  

  route_vpc_id = module.vpc.vpc_id
  route_table_private_nat_gateway_id = module.nat.nat_gw_id

  # route_table_association_private_subnet_id
  route_table_association_subnet_id = module.vpc.subnets_id

  route_table_public_gateway_id = module.igw.igw_id  
}

# module "userdata_module" {
#   source = "../../module/user_data"
# }

module "template1" {
  source = "../../module/template"
  launch_template_image_id = var.launch_template_image_id1
  launch_template_instance_type = var.launch_template_instance_type1
  launch_template_name_prefix = var.launch_template_name_prefix1
  launch_template_iam_instance_profile = var.launch_template_iam_instance_profile1
  launch_template_vpc_security_group_ids = module.vpc_sg.sg_id
  user_data_script = base64encode(var.user_data_script)
 
  
}

module "template2" {
  source = "../../module/template"
  launch_template_image_id = var.launch_template_image_id2
  launch_template_instance_type = var.launch_template_instance_type2
  launch_template_name_prefix = var.launch_template_name_prefix2
  launch_template_iam_instance_profile = var.launch_template_iam_instance_profile2
  launch_template_vpc_security_group_ids = module.vpc_sg.sg_id
  user_data_script = base64encode(var.user_data_script)

}





module "vpc_sg" {
  source = "../../module/sg"
  sg_name = "CGV-PRD-VPC-SG"
  sg_rule_vpd_id = module.vpc.vpc_id

  security_group_rules = var.vpc_security_group_rules
}

module "alb1" {
  source = "../../module/alb"
  lb_target_group_name = var.lb_target_group_name1
  lb_target_group_prot = var.lb_target_group_prot1
  lb_target_group_protocol = var.lb_target_group_protocol1
  lb_target_group_vpc_id = module.vpc.vpc_id

  lb_tg_health_check_enabled = var.lb_tg_health_check_enabled1
  lb_tg_health_check_interval = var.lb_tg_health_check_interval1
  lb_tg_health_check_path = var.lb_tg_health_check_path1
  lb_tg_health_check_port = var.lb_tg_health_check_port1
  lb_tg_health_check_timeout = var.lb_tg_health_check_timeout1
  lb_tg_health_check_healthy_threshold = var.lb_tg_health_check_healthy_threshold1
  lb_tg_health_check_unhealthy_threshold = var.lb_tg_health_check_unhealthy_threshold1

  lb_internal = var.lb_internal1
  lb_load_balancer_type = var.lb_load_balancer_type1
  lb_name = var.lb_name1
  lb_security_groups = module.vpc_sg.sg_id
  lb_enable_deletion_protection = var.lb_enable_deletion_protection1
  lb_subnet_mapping = module.vpc.public_subnet_id
  lb_listener_HTTP_port = var.lb_listener_HTTP_port1
  lb_listener_HTTP_protocol = var.lb_listener_HTTP_protocol1
  aws_devnote_dev_zone_name = var.aws_devnote_dev_zone_name1

 


}

module "alb2" {
  source = "../../module/alb"
  lb_target_group_name = var.lb_target_group_name2
  lb_target_group_prot = var.lb_target_group_prot2
  lb_target_group_protocol = var.lb_target_group_protocol2
  lb_target_group_vpc_id = module.vpc.vpc_id

  lb_tg_health_check_enabled = var.lb_tg_health_check_enabled2
  lb_tg_health_check_interval = var.lb_tg_health_check_interval2
  lb_tg_health_check_path = var.lb_tg_health_check_path2
  lb_tg_health_check_port = var.lb_tg_health_check_port2
  lb_tg_health_check_timeout = var.lb_tg_health_check_timeout2
  lb_tg_health_check_healthy_threshold = var.lb_tg_health_check_healthy_threshold2
  lb_tg_health_check_unhealthy_threshold = var.lb_tg_health_check_unhealthy_threshold2

  lb_internal = var.lb_internal2
  lb_load_balancer_type = var.lb_load_balancer_type2
  lb_name = var.lb_name2
  lb_security_groups = module.vpc_sg.sg_id
  lb_enable_deletion_protection = var.lb_enable_deletion_protection2
  lb_subnet_mapping = module.vpc.lb_subnet_id
  lb_listener_HTTP_port = var.lb_listener_HTTP_port2
  lb_listener_HTTP_protocol = var.lb_listener_HTTP_protocol2
  aws_devnote_dev_zone_name = var.aws_devnote_dev_zone_name2


}

module "asg1" {
  source = "../../module/asg"
  autoscaling_group_vpc_zone_identifier = module.vpc.asg1_subnet_id
  autoscaling_group_target_group_arns = module.alb1.lb_target_group_arn
  autoscaling_group_launch_template_id = module.template1.launch_template_id

  autoscaling_group_tag_key = var.autoscaling_group_tag_key
  autoscaling_group_tag_value = var.autoscaling_group_tag_value1
  autoscaling_group_tag_propagate_at_launch = var.autoscaling_group_tag_propagate_at_launch
  

# ##########3
#   autoscaling_group_tag_key2 = var.autoscaling_group_tag_key2
#   autoscaling_group_tag_value2 = var.autoscaling_group_tag_value1_1
#   autoscaling_group_tag_propagate_at_launch2 = var.autoscaling_group_tag_propagate_at_launch
# ##########
  autoscaling_policy_name = var.autoscaling_policy_name
  autoscaling_policy_policy_type = var.autoscaling_policy_policy_type
  autoscaling_policy_customized_metric_specification_metric_name = var.autoscaling_policy_customized_metric_specification_metric_name
  autoscaling_policy_customized_metric_specification_namespace = var.autoscaling_policy_customized_metric_specification_namespace
  autoscaling_policy_customized_metric_specification_statistic = var.autoscaling_policy_customized_metric_specification_statistic
  autoscaling_policy_customized_metric_specification_unit = var.autoscaling_policy_customized_metric_specification_unit
  autoscaling_policy_customized_metric_specification_target_value = var.autoscaling_policy_customized_metric_specification_target_value
  
}

module "asg2" {
  source = "../../module/asg"
  autoscaling_group_vpc_zone_identifier = module.vpc.asg2_subnet_id
  autoscaling_group_target_group_arns = module.alb2.lb_target_group_arn
  autoscaling_group_launch_template_id = module.template2.launch_template_id
  autoscaling_group_tag_key = var.autoscaling_group_tag_key
  autoscaling_group_tag_value = var.autoscaling_group_tag_value2
  autoscaling_group_tag_propagate_at_launch = var.autoscaling_group_tag_propagate_at_launch
  
# ##########3
#   autoscaling_group_tag_key2 = var.autoscaling_group_tag_key
#   autoscaling_group_tag_value2 = var.autoscaling_group_tag_value2_2
#   autoscaling_group_tag_propagate_at_launch2 = var.autoscaling_group_tag_propagate_at_launch
# ##########

  autoscaling_policy_name = var.autoscaling_policy_name
  autoscaling_policy_policy_type = var.autoscaling_policy_policy_type
  autoscaling_policy_customized_metric_specification_metric_name = var.autoscaling_policy_customized_metric_specification_metric_name
  autoscaling_policy_customized_metric_specification_namespace = var.autoscaling_policy_customized_metric_specification_namespace
  autoscaling_policy_customized_metric_specification_statistic = var.autoscaling_policy_customized_metric_specification_statistic
  autoscaling_policy_customized_metric_specification_unit = var.autoscaling_policy_customized_metric_specification_unit
  autoscaling_policy_customized_metric_specification_target_value = var.autoscaling_policy_customized_metric_specification_target_value

}

# module "spot_instance" {
#   source = "../../module/spot_instance"
#   launch_template_name = var.launch_template_image_id1
#   spot_type = var.spot_type
#   spot_price = var.spot_price

#   //spot_vpc_id = module.vpc.vpc_id


# }

terraform {
  backend "s3" {
    bucket         = "cgv-terraform-tf.state-bucket"
    key            = "..terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    
  }
}