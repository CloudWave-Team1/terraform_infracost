data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_launch_template" "launch_template" {
  description           = "CGV-EC2-basic-start-template"
  image_id      = var.launch_template_image_id
  instance_type = var.launch_template_instance_type
  name_prefix   = var.launch_template_name_prefix
  user_data     = var.user_data_script

  instance_market_options {
    market_type = "spot"
    
    spot_options {
      instance_interruption_behavior = "terminate"
      max_price = "1"
      
    }
    
  }
  

  vpc_security_group_ids = [var.launch_template_vpc_security_group_ids]
  

    iam_instance_profile {
    name = var.launch_template_iam_instance_profile
    # aws_iam_instance_profile.ec2_rds_s3_access_ssm_profile.name
  }
}

