resource "aws_ecr_repository" "base_image" {
  name                 = "${var.stack}-${var.environment}-base-image"
  image_tag_mutability = "MUTABLE"
  tags = {
    Name = "${var.stack}-${var.environment}-base-image"
    Environment = "${var.environment}"
    Billing = "${var.billing_id}"
  }
}

resource "aws_ecr_repository" "image_repo" {
  name                 = "${var.stack}-${var.environment}-image"
  image_tag_mutability = "MUTABLE"
  tags = {
    Name = "${var.stack}-${var.environment}-image"
    Environment = "${var.environment}"
    Billing = "${var.billing_id}"
  }
}

output "base_image_repo_url" {
  value = aws_ecr_repository.base_image.repository_url
}

output "image_repo_url" {
  value = aws_ecr_repository.image_repo.repository_url
}

output "base_image_repo_arn" {
  value = aws_ecr_repository.base_image.arn
}

output "image_repo_arn" {
  value = aws_ecr_repository.image_repo.arn
}