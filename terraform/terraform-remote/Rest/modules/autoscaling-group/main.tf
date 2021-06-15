


resource "aws_launch_template" "LaunchTemplate" {
  name = "nomanikram_flaskapp_lt"

  key_name = var.ec2_config.pem
  instance_type = var.ec2_config.instance_type
  image_id = var.ec2_config.ami
  vpc_security_group_ids = [ var.security_groups.FlaskApp_SG.id ]
  user_data =  base64encode(templatefile("./modules/autoscaling-group/userdata.sh", {
    "privateip" = var.database.instance.private_ip
  }))

   tags = {
    Name = "${var.setting.project_title}-${var.setting.environment}-FlaskApp-LT"
  }

}

resource "aws_autoscaling_group" "flask_app_asg" {
  vpc_zone_identifier = [
      var.vpc.PrivateSubnet[0].id,
      var.vpc.PrivateSubnet[1].id
  ]

  desired_capacity   = var.asg.desired_capacity # 2
  max_size           = var.asg.max_size # 4
  min_size           = var.asg.min_size # 2

  target_group_arns = [ var.ALB.TargetGroup.arn ]

  launch_template {
    id      = aws_launch_template.LaunchTemplate.id
    version = "$Latest"
  }

  tags = [
    {
      key                 = "Name"
      value               = "${var.setting.project_title}-${var.setting.environment}-FlaskApp-ASG"
      propagate_at_launch = true
    }
]
}