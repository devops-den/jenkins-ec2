resource "aws_iam_role" "Jenkins-iam-s3-role" {
  name               = "Jenkins-iam-s3-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "Jenkins-iam-role-instanceprofile" {
  name = "Jenkins-iam-role-profile"
  role = aws_iam_role.Jenkins-iam-s3-role.name
}

resource "aws_iam_role_policy" "Jenkins-iam-role-policy" {
  name   = "Jenkins-iam-role-policy"
  role   = aws_iam_role.Jenkins-iam-s3-role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action":[
                "s3:*",
                "ec2:*",
                "iam:*",
                "rds:*",
"elasticloadbalancing:*",
"autoscaling:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}