resource "aws_iam_user" "ecr-user" {
  name = "${var.stack}-ecr-user"
  
}

/*
data "aws_iam_policy_document" "example" {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:PutImage",
                "ecr:PutImageScanningConfiguration"
            ],
            "Resource": [
                "arn:aws:ecr:<REGION>:<AWS_ACCOUNT_ID>:repository/<ECR_REPO_WEBSERVER>",
                "arn:aws:ecr:<REGION>:<AWS_ACCOUNT_ID>:repository/<ECR_REPO_WEBSITE>"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "ecr:GetAuthorizationToken",
            "Resource": "*"
        }
    ]
}

*/
resource “aws_iam_policy” “example” {
 name = “ec2-read-only”
 policy = “${data.aws_iam_policy_document.example.json}”
}