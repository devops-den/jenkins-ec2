
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }
  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}

# resource "aws_instance" "jenkins-instance" {
#   ami = data.aws_ami.amazon-linux-2.id
#   # ami             = "ami-013f17f36f8b1fefb" // ubuntu ami image
#   instance_type = var.instance_type
#   key_name      = var.keyname
#   #vpc_id          = "${aws_vpc.development-vpc.id}"
#   vpc_security_group_ids = [aws_security_group.sg_allow_ssh_jenkins.id]
#   subnet_id              = aws_subnet.jenkins-public-subnet-1.id
#   user_data              = file("install_jenkins.sh")
#   iam_instance_profile   = aws_iam_instance_profile.Jenkins-iam-role-instanceprofile.name

#   associate_public_ip_address = true
#   tags = {
#     Name = "Jenkins-Instance"
#   }
# }

data "aws_instance" "jenkins" {
  depends_on = [
    aws_autoscaling_group.this
  ]
  filter {
    name   = "tag:Name"
    values = ["Jenkins-Server"]
  }
}

output "jenkins_ip_address" {
  value = data.aws_instance.jenkins.public_dns
}
