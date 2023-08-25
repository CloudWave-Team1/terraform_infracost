resource "aws_autoscaling_group" "autoscaling_group" {
  desired_capacity     = 2
  max_size             = 10
  min_size             = 2
  vpc_zone_identifier  = var.autoscaling_group_vpc_zone_identifier 
  target_group_arns    = [var.autoscaling_group_target_group_arns]

  launch_template {
    id      = var.autoscaling_group_launch_template_id
    version = "$Latest"
  }


  tag {
    key                 = var.autoscaling_group_tag_key
    value               = var.autoscaling_group_tag_value
    propagate_at_launch = var.autoscaling_group_tag_propagate_at_launch
 
 }

#    tag {
#     key                 = var.autoscaling_group_tag_key2
#     value               = var.autoscaling_group_tag_value2
#     propagate_at_launch = var.autoscaling_group_tag_propagate_at_launch2
#  }
}

resource "aws_autoscaling_policy" "autoscaling_policy" {
  name                   = var.autoscaling_policy_name
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
  policy_type            = var.autoscaling_policy_policy_type

   target_tracking_configuration {
    customized_metric_specification {
      metric_name = var.autoscaling_policy_customized_metric_specification_metric_name
      namespace   = var.autoscaling_policy_customized_metric_specification_namespace
      statistic   = var.autoscaling_policy_customized_metric_specification_statistic
      unit = var.autoscaling_policy_customized_metric_specification_unit
    }
    target_value = var.autoscaling_policy_customized_metric_specification_target_value # 이 값을 원하는 대상당 요청 수로 변경하세요
  }
}