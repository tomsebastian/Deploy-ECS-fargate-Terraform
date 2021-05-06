variable "aws_region" {
  description = "The AWS region to create things in."
  
}

variable "aws_profile" {
  description = "AWS profile"
}

variable "stack" {
  description = "Name of the stack."
  default     = "Test-ECS-Terraform"
}

variable environment {
  description = "Name of environment"
  default     = "testing"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.1.0.0/16"
}

variable "az_count" {
  description = "Number of AZs to cover in the given AWS region"
  default     = "3"
}

