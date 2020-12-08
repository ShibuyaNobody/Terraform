resource "aws_iam_user" "s3_full_access_user" {
  name = "s3-full-access-user"

  tags = {
    Name = "s3-full-access-user"
  }
}

resource "aws_iam_access_key" "s3_full_access" {
  user = aws_iam_user.s3_full_access_user.name
}

resource "aws_iam_user_policy" "s3_full_access_policy" {
  name = "s3-full-access-policy"
  user = aws_iam_user.s3_full_access_user.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["s3:*"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:iam::aws:policy/AmazonS3FullAccess"
      ]
    }
  ]
}
EOF
} 