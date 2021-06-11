


resource "aws_launch_template" "LaunchTemplate" {
  name = "nomanikram_flaskapp_lt"

  key_name = var.PEM_Key
  instance_type = var.Instance_Type
  image_id = var.Ami
  vpc_security_group_ids = [ var.FlaskApp_SG.id ]
  user_data =  base64encode(templatefile("./modules/autoscaling-group/userdata.sh", {
    "privateip" = var.Database.private_ip
  }))

   tags = {
    Name = "${var.ProjectTitle}-${var.Environment}-FlaskApp-LT"
  }

}

resource "aws_autoscaling_group" "flask_app_asg" {
  vpc_zone_identifier = [
      var.PrivateSubnet1b.id,
      var.PrivateSubnet2b.id
  ]

  desired_capacity   = 2
  max_size           = 4
  min_size           = 2

  target_group_arns = [ var.TargetGroup.arn ]

  launch_template {
    id      = aws_launch_template.LaunchTemplate.id
    version = "$Latest"
  }

  tags = [
    {
      key                 = "Name"
      value               = "${var.ProjectTitle}-${var.Environment}-FlaskApp-ASG"
      propagate_at_launch = true
    }
]
}