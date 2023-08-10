#vpc atttributes
project_name         = "Technodemics"
project_name_b       = "Techno"
region               = "us-west-1"
env                  = "prod"
vpc_cidr             = "10.0.0.0/16"
instance_tenancy     = "default"
enable_dns_hostnames = true
enable_dns_support   = true

#subnet attributes
descriptor_a                                = "WebApp"
descriptor_b                                = "Database"
public_subnets_cidr                         = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_cidr                        = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zone_webapp                    = ["us-west-1a", "us-west-1b"]
availability_zone_database                  = ["us-west-1b", "us-west-1a"]
map_public_ip_on_launch                     = true
enable_resource_name_dns_a_record_on_launch = true

#ssh ingress IP. (change to private IP DURING PROD)
ssh_location = "0.0.0.0/0"

#RDS db subnet group
database_subnets = "techno_db_subnets"

#RDS Instance parameters
engine                = "postgres"
engine_version        = "15.3"
multi_az              = false
identifier            = "postgres"
username              = "eseadmin"
password              = "imgettingbetter"
instance_class        = "db.t3.micro"
allocated_storage     = "30"
max_allocated_storage = "100"
/*db_subnet_group_name  = "techno_db_subnets"
vpc_security_group_ids  = [aws_security_group.web_server_sg.id]*/
availability_zone_db = "us-west-1b"
db_name              = "Techno_db"
skip_final_snapshot  = true

#ALB Target groups
target_group_name          = "techno-tgrp"
target_group_type          = "ip"
health_check_status        = true
health_check_interval      = "10"
target_group_timeout       = "5"
healthy_threshold          = "5"
unhealthy_threshold        = "2"
health_check_path          = "/"
load_balancer_name         = "techno-load-balancer"
load_balancer_internal     = false
load_balancer_type         = "application"
enable_deletion_protection = false

#route53
domain_name      = "technodemics.com"
alternative_name = "*.technodemics.com"

#ECS
ecs_cluster_name = "techno-cluster"
log_group_name   = "techno-log-group"
ecs_family_name  = "techno-tasks"

network_mode = "awsvpc"
# cpu_architecture = ""
launch_type             = "FARGATE"
platform_version        = "LATEST"
desired_count           = "2"
minimum_healthy_percent = "100"
deployment_max_percent  = "200"
enable_managed_tags     = false
propagate_tags          = "SERVICE"
task_definition_cpu     = "2048"
task_definition_memory  = "4096"
operating_system        = "LINUX"
container_image         = "742199688573.dkr.ecr.us-west-1.amazonaws.com/elearning"
#containerPort           = "80"
#hostPort                = "80"
container_port = "80"
