# create ecs cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name

  /*setting {
    name  = "containerInsights"
    value = "disabled"
  }*/
}


# create cloudwatch log group
resource "aws_cloudwatch_log_group" "log_group" {
  #name = "/ecs/${}-${}-td"
  name = var.log_group_name

  lifecycle {
    create_before_destroy = true
  }
}



# create task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = var.ecs_family_name
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = var.network_mode
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory

  runtime_platform {
    operating_system_family = var.operating_system
  }


  # create container definition
  container_definitions = jsonencode([
    {
      name      = "${var.project_name_c}-container"
      image     = "${var.container_image}"
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]

      /*environmentFiles = [
        {
          value = "arn:aws:s3:::${}-${}/${}"
          type  = "s3"
        }
      ]*/

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = "${aws_cloudwatch_log_group.log_group.name}",
          "awslogs-region"        = "${var.region}",
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}


# create ecs service
resource "aws_ecs_service" "ecs_service" {
  name                               = "${var.project_name_c}-service"
  launch_type                        = var.launch_type
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.ecs_task_definition.arn
  platform_version                   = var.platform_version
  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = var.minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_max_percent


  # task tagging configuration
  enable_ecs_managed_tags = var.enable_managed_tags
  propagate_tags          = var.propagate_tags


  # vpc and security groups
  network_configuration {
    subnets          = aws_subnet.private_subnets.*.id
    security_groups  = ["${aws_security_group.web_server_sg.id}"]
    assign_public_ip = false
  }

  # load balancing
  load_balancer {
    target_group_arn = aws_lb_target_group.techno_target_group.arn
    container_name   = "${var.project_name_c}-container"
    container_port   = 80
  }
}

