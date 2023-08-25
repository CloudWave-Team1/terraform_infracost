variable "launch_template_image_id" {}
  # aws 2023 ami 이미지 id 자주 바뀜
  # default = "ami-0d3120170251f6a8f" // 우리가 만든 ami?


variable "launch_template_instance_type" {}

variable "launch_template_name_prefix" {}

variable "launch_template_vpc_security_group_ids" {}

variable "launch_template_iam_instance_profile" {}

variable "user_data_script" {}

variable "max_price" {}

variable "min_price" {}
