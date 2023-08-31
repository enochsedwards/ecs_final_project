variable "region" {}
variable "project_name" {}
variable "project_name_b" {}
variable "project_name_c" {}
variable "project_name_d" {}
variable "env" {}
variable "vpc_cidr" {}
variable "instance_tenancy" {}
variable "enable_dns_hostnames" {}
variable "enable_dns_support" {}
variable "public_subnets_cidr" {}
variable "availability_zone_webapp" {}
variable "map_public_ip_on_launch" {}
variable "enable_resource_name_dns_a_record_on_launch" {}
variable "descriptor_a" {}
variable "private_subnets_cidr" {}
variable "availability_zone_database" {}
variable "descriptor_b" {}
variable "ssh_location" {
  description = "choose the IP address to ssh in"
}

#security group
variable "sg_ingress" {}

/*variable "vpc_security_group_ids" {}*/
/*variable "role" {}*/
variable "database_subnets" {}

variable "engine" {}
variable "engine_version" {}
variable "multi_az" {}
variable "identifier" {}
variable "username" {}
variable "password" {
  description = "RDS root user password"
  sensitive   = true
}
variable "instance_class" {}
variable "allocated_storage" {}
variable "max_allocated_storage" {}
/*variable "db_subnet_group_name" {}*/
variable "availability_zone_db" {}
variable "db_name" {}
variable "skip_final_snapshot" {}

variable "health_check_status" {}
variable "health_check_interval" {}
variable "healthy_threshold" {}
variable "unhealthy_threshold" {}
variable "target_group_name" {}
variable "target_group_type" {}
variable "target_group_timeout" {}
variable "health_check_path" {}
variable "load_balancer_name" {}
variable "load_balancer_internal" {}
variable "load_balancer_type" {}
variable "enable_deletion_protection" {}

variable "domain_name" {}
variable "alternative_name" {}

#listeners
#variable "certificate_arn" {}

variable "log_group_name" {}
variable "ecs_cluster_name" {}
variable "ecs_family_name" {}
#variable "execution_role_arn" {}
variable "network_mode" {}
#variable "cpu_architecture" {}
variable "launch_type" {}
variable "platform_version" {}
variable "desired_count" {}

variable "minimum_healthy_percent" {}
variable "deployment_max_percent" {}
variable "enable_managed_tags" {}

variable "propagate_tags" {}
#variable "web_server_sg" {}
#variable "alb_target_group_arn" {}
variable "task_definition_cpu" {}
variable "task_definition_memory" {}
variable "operating_system" {}
#containeer definition
variable "container_image" {}
#variable "containerPort" {}
#variable "hostPort" {}
variable "container_port" {}

#dynamo db table
#variable "dynamo_db_name" {}
variable "write_capacity" {}
variable "read_capacity" {}

#Route53 Attributes
/*variable "root_domain_name" {}
variable "sub_domain_name" {}*/
