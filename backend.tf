terraform {
  backend "s3" {
    bucket = "kringle-aws-jenkins-terraform"
    key    = "jenkins.terraform.tfstate"
    region = "us-east-1"
  }
}