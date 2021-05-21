resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.stack}-${var.environment}-Cluster"
  tags = {
    Name = "${var.stack}-${var.environment}-cluster"
    Environment = "${var.environment}"
    Billing = "${var.billing_id}"
  }
}


resource "aws_ecs_task_definition" "task-def" {
  family                   = "${var.stack}-${var.environment}-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  //task_role_arn            = "${aws_iam_role.ecs-tasks-service-role.arn}"
  execution_role_arn       = aws_iam_role.tasks-service-role.arn
  

  container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.fargate_cpu},
    "image": "${aws_ecr_repository.image_repo.repository_url}",
    "memory": ${var.fargate_memory},
    "name": "${var.stack}-${var.environment}-container",
    "networkMode": "awsvpc",
    "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "ecs/${var.stack}-${var.environment}",
                "awslogs-region": "${var.aws_region}",
                "awslogs-stream-prefix": "${var.cw_log_stream}"
            }
        },
    
    "portMappings": [
      {
        "containerPort": ${var.container_port},
        "hostPort": ${var.container_port}
      }
    ]
  }
]
DEFINITION
tags = {
    Name = "${var.stack}-${var.environment}-task-def"
    Environment = "${var.environment}"
    Billing = "${var.billing_id}"
  }
}

#ecs service

resource "aws_ecs_service" "service" {
  name            = "${var.stack}-${var.environment}-Service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.task-def.arn
  desired_count   = var.task_count
  launch_type     = "FARGATE"
  depends_on = [aws_alb_listener.alb-listener,]
  
  network_configuration {
    security_groups = [aws_security_group.task-sg.id]
    subnets         = aws_subnet.public.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.trgp.id
    container_name   = "${var.stack}-${var.environment}-container"
    container_port   = var.container_port
  }
  
  tags = {
    Name = "${var.stack}-${var.environment}-ecs-service"
    Environment = "${var.environment}"
    Billing = "${var.billing_id}"
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}

resource "aws_cloudwatch_log_group" "cw-lgrp" {
  name = "ecs/${var.stack}-${var.environment}"
}
