data "aws_route53_zone" "primary" {
  name = "kringle.in"
}

resource "aws_route53_record" "jenkins" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "jenkins.${data.aws_route53_zone.primary.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.jenkins-instance.public_ip]
}