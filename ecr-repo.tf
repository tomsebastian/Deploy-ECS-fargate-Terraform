resource "aws_ecr_repository" "base_image" {
  name                 = "${var.stack}-base-image"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "image_repo" {
  name                 = "${var.stack}-image"
  image_tag_mutability = "MUTABLE"
}

output "image_repo_url" {
  value = aws_ecr_repository.base-image.repository_url
}

output "image_repo_url" {
  value = aws_ecr_repository.image_repo.repository_url
}

output "image_repo_arn" {
  value = aws_ecr_repository.base_image_repo.arn
}

output "image_repo_arn" {
  value = aws_ecr_repository.image_repo.arn
}