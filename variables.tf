variable "aws_region" {
  description = "The AWS region to create things in."
  
}

variable "aws_profile" {
  description = "AWS profile"
}

variable "account_id" {
  description = "account_id"
}


variable "stack" {
  description = "Name of the stack."
  default     = "test-ecs-terraform"
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

variable "container_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "task_count" {
  description = "Number of ECS tasks to run"
  default     = 1
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}


variable "source_repo_branch" {
    description = "Source repo branch"
    type = string
}

#ecs cloudwatch

variable "cw_log_stream" {
  description = "CloudWatch Log Stream"
  default     = "ecs"
}


variable "db_instance_type" {
  description = "RDS instance type"
  default     = "db.r4.2xlarge"
}

variable "db_name" {
  description = "RDS DB name"
  default     = "database"
}

variable "db_user" {
  description = "RDS DB username"
  default     = "root"
}

variable "db_password" {
  description = "RDS DB password"
  default = "password"
}