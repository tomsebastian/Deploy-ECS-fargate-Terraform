resource "aws_iam_user" "ecr-user" {
  name = "${var.stack}-ecr-user"
  
}

data "template_file" "policy" {
  template = "${file("ecr-policy.json")}"
  vars = {
    bucket_name = "dummy_bucket"
  }
}

resource "aws_iam_user_policy" "ecr_policy" {
  name = "ecr-policy"
  user = "${aws_iam_user.ecr-user.name}"
  policy = "${data.template_file.policy.rendered}"
}

/*
data "aws_iam_policy_document" "example" {
    version = 2012-10-17
    statement = [
        {    
            Sid = "VisualEditor0",
            Effect = "Allow",
            Action = [
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:PutImage",
                "ecr:PutImageScanningConfiguration"
            ],
            Resource = [
                "arn:aws:ecr:us-east-1:862567339542:repository/${var.stack}-image",
                "arn:aws:ecr:us-east-1:862567339542:repository/${var.stack}-base-image"
            ]
        },
        {
            Sid = "VisualEditor1",
            Effect = "Allow",
            Action = "ecr:GetAuthorizationToken",
            Resource = "*"
        }
    ]
}

*/

