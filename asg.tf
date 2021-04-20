resource "aws_launch_template" "this" {
  image_id               = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  key_name               = var.keyname
  user_data              = filebase64("install_jenkins.sh")


  iam_instance_profile {
    name = aws_iam_instance_profile.Jenkins-iam-role-instanceprofile.name
  }

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.jenkins-public-subnet-1.id
    security_groups             = [aws_security_group.sg_allow_ssh_jenkins.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Jenkins-Server"
    }
  }
}

resource "aws_autoscaling_group" "this" {
  availability_zones = ["${var.region}a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }

  tag {
    key                 = "Name"
    value               = "Jenkins-Server"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }
}