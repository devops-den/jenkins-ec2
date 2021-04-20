# alb
resource "aws_lb" "this" {
  name               = "jenkins-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_allow_ssh_jenkins.id]
  subnets            = [aws_subnet.jenkins-public-subnet-1.id, aws_subnet.jenkins-public-subnet-2.id]
}

# Target Group
resource "aws_lb_target_group" "this" {
  name     = "jenkins-alb-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.jenkins-vpc.id
  health_check {
    port = 8080
    interval = 300
  }
}

# resource "aws_lb_target_group_attachment" "this" {
#   target_group_arn = aws_lb_target_group.this.arn
#   target_id        = aws_instance.jenkins-instance.id
#   port             = 8080
# }

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.this.id
  alb_target_group_arn   = aws_lb_target_group.this.arn
}

# alb listener
resource "aws_alb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.this.arn
    type             = "forward"
  }
}