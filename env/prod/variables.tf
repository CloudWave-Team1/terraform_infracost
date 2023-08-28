variable "vpc_cidr" {
    default = "10.2.0.0/16"
}

variable "vpc_name" {
    default = "CGV-PRD-VPC"
}


variable "subnet_name_cidr" {
    default = [
        { name = "CGV-PRD-PUB1", cidr = "10.2.1.0/24"},
        { name = "CGV-PRD-PUB2", cidr = "10.2.2.0/24"},
        { name = "CGV-PRD-PRI3", cidr = "10.2.3.0/24"},
        { name = "CGV-PRD-PRI4", cidr = "10.2.4.0/24"},
        { name = "CGV-PRD-PRI5", cidr = "10.2.5.0/24"},
        { name = "CGV-PRD-PRI6", cidr = "10.2.6.0/24"},
        { name = "CGV-PRD-PRI7", cidr = "10.2.7.0/24"},
        { name = "CGV-PRD-PRI8", cidr = "10.2.8.0/24"}
        
    ]
}

variable "availability_zone" {
    default = ["ap-northeast-2a","ap-northeast-2c"]
}

variable "igw_name" {
    default = "CGV-PRD-IGW"
}

variable "nat_gateway_name" {
    default = "CGV-PRD-NGW"
}


variable "nat_gateway_count" {
    default = 2
}

# ec2 1번 에 대한 launch template
variable "launch_template_image_id1" {
  default = "ami-05634c6f3241a48d8" # aws 2023 ami 이미지 id 자주 바뀜
  # default = "ami-0d3120170251f6a8f" // 우리가 만든 ami?
 }

variable "launch_template_instance_type1" {
  default = "t2.micro"
}

variable "launch_template_name_prefix1" {
  default = "CGV-EC2-basic-start-template"
}

 variable "launch_template_vpc_security_group_ids1" {
     default = []
 }

variable "launch_template_iam_instance_profile1" {
    default = "CGV-WEB-role"
}

#두번째 ec2에 대한 lauch template
variable "launch_template_image_id2" {
  default = "ami-05634c6f3241a48d8" # aws 2023 ami 이미지 id 자주 바뀜
  # default = "" // 우리가 만든 ami?
 }

variable "launch_template_instance_type2" {
  default = "t2.micro"
}

variable "launch_template_name_prefix2" {
  default = "CGV-EC2-basic-start-template"
}

 variable "launch_template_vpc_security_group_ids2" {
     default = []
 }

variable "launch_template_iam_instance_profile2" {
    default = "CGV-WAS-role"
}


variable "vpc_security_group_rules" {
    description = "List of security group rules"
  type        = list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      type        = "ingress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}


##alb varibles

variable "aws_devnote_dev_zone_name1" {
  default = "aws.devnote.dev"
}

variable "lb_target_group_name1" {
  default = "CGV-PRD-TG1"
}

variable "lb_target_group_prot1" {
  default = 80
}

variable "lb_target_group_protocol1" {
  default = "HTTP"
}

variable "lb_target_group_vpc_id" {
  default = []
}

variable "lb_tg_health_check_enabled1" {
    default = true
}
variable "lb_tg_health_check_interval1" {
      default = 30
}
variable "lb_tg_health_check_path1" {
      default = "/admin"
}
variable "lb_tg_health_check_port1" {
      default = 8080
}
variable "lb_tg_health_check_timeout1" {
      default = 5
}
variable "lb_tg_health_check_healthy_threshold1" {
      default = 3
}
variable "lb_tg_health_check_unhealthy_threshold1" {
      default = 3
}

variable "lb_internal1" {
  default = false
  }

variable "lb_load_balancer_type1" {
  default = "application"
}
variable "lb_name1" {
  default = "CGV-PRD-LB1"
}

variable "lb_security_groups1" {
    default = []
}

variable "lb_subnet_mapping1" {
   
  type    = set(string)
  default = []  # 예시 서브넷 ID, 실제 서브넷 ID로 수정 필요
}


variable "lb_enable_deletion_protection1" {
  default = false
}

variable "lb_listener_HTTP_port1" {
      default = "80"
}

variable "lb_listener_HTTP_protocol1" {
    default = "HTTP"
}


## 두번째 alb variables
variable "aws_devnote_dev_zone_name2" {
  default = "aws.devnote.dev"
}

variable "lb_target_group_name2" {
  default = "CGV-PRD-TG2"
}

variable "lb_target_group_prot2" {
  default = 80
}

variable "lb_target_group_protocol2" {
  default = "HTTP"
}


variable "lb_tg_health_check_enabled2" {
    default = true
}
variable "lb_tg_health_check_interval2" {
      default = 30
}
variable "lb_tg_health_check_path2" {
      default = "/admin"
}
variable "lb_tg_health_check_port2" {
      default = 80
}
variable "lb_tg_health_check_timeout2" {
      default = 5
}
variable "lb_tg_health_check_healthy_threshold2" {
      default = 3
}
variable "lb_tg_health_check_unhealthy_threshold2" {
      default = 3
}

variable "lb_internal2" {
  default = false
  }

variable "lb_load_balancer_type2" {
  default = "application"
}
variable "lb_name2" {
  default = "CGV-PRD-LB2"
}

variable "lb_security_groups2" {
    default = []
}

variable "lb_subnet_mapping2" {
   
  type    = set(string)
  default = []  # 예시 서브넷 ID, 실제 서브넷 ID로 수정 필요
}


variable "lb_enable_deletion_protection2" {
  default = false
}

variable "lb_listener_HTTP_port2" {
      default = "80"
}

variable "lb_listener_HTTP_protocol2" {
    default = "HTTP"
}

##asg의 variables

variable "autoscaling_group_vpc_zone_identifier" {
     type    = list(string)
     default = []
}
//variable "autoscaling_group_target_group_arns" {}

//variable "autoscaling_group_launch_template_id" {}

variable "autoscaling_group_tag_key" {
  default = "Name"
}

# variable "autoscaling_group_tag_key2" {
#   default = "Backup"
# }

variable "autoscaling_group_tag_value1" {
  default = "CGV-WEB-EC2"
}

# variable "autoscaling_group_tag_value1_1" {
#   default = "WEB"
# }

variable "autoscaling_group_tag_value2" {
  default = "CGV-WAS-EC2"
}

# variable "autoscaling_group_tag_value2_2" {
#   default = "WAS"
# }

variable "autoscaling_group_tag_propagate_at_launch" {
  default = true
}

variable "autoscaling_policy_name" {
  default = "CGV-PRD-ASG-Policy"
}

variable "autoscaling_policy_policy_type" {
  default = "TargetTrackingScaling"
}

variable "autoscaling_policy_customized_metric_specification_metric_name" {
  default = "RequestCountPerTarget"
}

variable "autoscaling_policy_customized_metric_specification_namespace" {
  default = "AWS/ApplicationELB"
}

variable "autoscaling_policy_customized_metric_specification_statistic" {
  default = "Average"
}

variable "autoscaling_policy_customized_metric_specification_unit" {
  default = "Count"
}

variable "autoscaling_policy_customized_metric_specification_target_value" {
  default = 1000.0
}

variable "user_data_script" {
  description = "User data script content"
  type        = string
  default     = <<-EOT
    #!/bin/bash
    cd /home/ec2-user/apps
    java -jar app.jar
    EOT
}
