resource "aws_iam_user" "ecr-user" {
  name = "${var.stack}-ecr-user"
  
}

/*
data "aws_iam_policy_document" "example" {
    statement  {
            sid = "VisualEditor0"
            effect = "Allow"
            actions = [
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:PutImage",
                "ecr:PutImageScanningConfiguration",
            ]
            resources = [
                "arn:aws:ecr:us-east-1:862567339542:repository/${var.stack}-image",
                "arn:aws:ecr:us-east-1:862567339542:repository/${var.stack}-base-image"
            ]
    }
    statement  {
            sid = "VisualEditor1"
            effect = "Allow"
            actions = ["ecr:GetAuthorizationToken"]
            resources = ["*"]
        }
  
  }


resource "aws_iam_user_policy" "ecr_policy" {
  name = "ecr-policy"
  user = "${aws_iam_user.ecr-user.name}"
 # path   = "/"
  #policy = data.aws_iam_policy_document.example.json
  policy = data.aws_iam_policy_document.example.json
}
*/

resource "aws_iam_policy" "ecr-policy" {
  name        = "${var.stack}-${var.environment}-ecr-policy"
  description = "ecr policy"

  policy = <<EOF
{
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
                "arn:aws:ecr:${var.aws_region}:${var.account_id}:repository/${var.stack}-${var.environment}-image",
                "arn:aws:ecr:${var.aws_region}:${var.account_id}:repository/${var.stack}-${var.environment}-base-image"
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
EOF
}

resource "aws_iam_policy_attachment" "ecr-attach-policy" {
  name       = "ecr-attachment"
  users      = [aws_iam_user.ecr-user.name]
  policy_arn = aws_iam_policy.ecr-policy.arn
}


