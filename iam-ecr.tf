resource "aws_iam_user" "ecr-user" {
  name = "${var.stack}-ecr-user"
  
}

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

/*

data "template_file" "policy" {
  template = "${file("ecr-policy.json")}"
  vars = {
    bucket_name = "dummy_bucket"
  }
}
*/

