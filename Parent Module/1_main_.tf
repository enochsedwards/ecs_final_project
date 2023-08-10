#Creating  modules
module "elearning" {
  #vpc atttributes
  source               = "../Child_Module"
  project_name         = var.project_name
  project_name_b       = var.project_name_b
  project_name_c       = var.project_name_c
  project_name_d       = var.project_name_d
  region               = var.region
  env                  = var.env
  vpc_cidr             = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  #subnet attributes
  descriptor_a                                = var.descriptor_a
  descriptor_b                                = var.descriptor_b
  public_subnets_cidr                         = var.public_subnets_cidr
  private_subnets_cidr                        = var.private_subnets_cidr
  availability_zone_webapp                    = var.availability_zone_webapp
  availability_zone_database                  = var.availability_zone_database
  map_public_ip_on_launch                     = var.map_public_ip_on_launch
  enable_resource_name_dns_a_record_on_launch = var.enable_resource_name_dns_a_record_on_launch

  #ssh ingress IP. (change to private IP DURING PROD)

  ssh_location = var.ssh_location
  #RDS db subnet group
  database_subnets = var.database_subnets
  #RDS Instance parameters
  engine                = var.engine
  engine_version        = var.engine_version
  multi_az              = var.multi_az
  identifier            = var.identifier
  username              = var.username
  password              = var.password
  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  /*db_subnet_group_name  = "techno_db_subnets"
    vpc_security_group_ids  = [aws_security_group.web_server_sg.id]*/
  /*db_subnet_group_name  = "techno_db_subnets"
  vpc_security_group_ids  = [aws_security_group.web_server_sg.id]*/
  availability_zone_db = var.availability_zone_db
  db_name              = var.db_name
  skip_final_snapshot  = var.skip_final_snapshot

  #ALB Target groups
  target_group_name          = var.target_group_name
  target_group_type          = var.target_group_type
  health_check_status        = var.health_check_status
  health_check_interval      = var.health_check_interval
  target_group_timeout       = var.target_group_timeout
  healthy_threshold          = var.healthy_threshold
  unhealthy_threshold        = var.unhealthy_threshold
  health_check_path          = var.health_check_path
  load_balancer_name         = var.load_balancer_name
  load_balancer_internal     = var.load_balancer_internal
  load_balancer_type         = var.load_balancer_type
  enable_deletion_protection = var.enable_deletion_protection

  #acm
  domain_name      = var.domain_name
  alternative_name = var.alternative_name


  #ecs
  ecs_cluster_name = var.ecs_cluster_name
  log_group_name   = var.log_group_name
  ecs_family_name  = var.ecs_family_name
  #execution_role_arn      = var.execution_role_arn
  network_mode = var.network_mode
  #cpu_architecture       = var.cpu_architecture
  launch_type             = var.launch_type
  platform_version        = var.platform_version
  desired_count           = var.desired_count
  minimum_healthy_percent = var.minimum_healthy_percent
  deployment_max_percent  = var.deployment_max_percent
  enable_managed_tags     = var.enable_managed_tags
  propagate_tags          = var.propagate_tags
  #web_server_sg          = var.web_server_sg
  #alb_target_group_arn   = var.alb_target_group_arn
  task_definition_cpu    = var.task_definition_cpu
  task_definition_memory = var.task_definition_memory
  operating_system       = var.operating_system
  container_image        = var.container_image
  #containerPort         = var.containerPort
  #hostPort              = var.hostPort
  container_port = var.container_port

  #dynamo db table
  #dynamo db table
  #dynamo_db_name        = var.dynamo_db_name
  # write_capacity = var.write_capacity
  #read_capacity  = var.read_capacity














}
