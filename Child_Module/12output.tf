output "vpc_id" {
  description = "RDS instance hostname"
  value       = aws_vpc.vpc.id
}

output "elastic-iP" {
  description = "elastic-iP ID"
  value       = aws_eip.elastic-iP.id
}

output "gateway_id" {
  description = "gateway id"
  value       = aws_internet_gateway.internet-gateway.id
}

output "public_route_table_id" {
  description = "public_route_table id"
  value       = aws_route_table.public-route-table.id
}

output "private_route_table_id" {
  description = "private_route_table id"
  value       = aws_route_table.private-route-table.id
}

output "alb_sg" {
  description = "Application Load balance SG id"
  value       = aws_security_group.alb_sg.id
}


output "web_server_sg" {
  description = "Websever  SG id"
  value       = aws_security_group.ssh_sg.id
}


/*output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.education.address
  sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.education.port
  sensitive   = true
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.education.username
  sensitive   = true
}*/

output "domain_name" {
  value = var.domain_name
}

/*output "certificate_arn" {
  value = aws_acm_certificate.acm_certificate.arn
}*/

output "aws_lb_target_group_arn" {
  value = aws_lb_target_group.techno_target_group.arn
}


output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "public_subnets_id" {
  value = aws_subnet.public_subnets[*]
}

output "private_subnets_id" {
  value = aws_subnet.private_subnets[*]
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

/*# export the s3 bucket name
output "s3_bucket" {
  value = 
}*/

# export the environment file name
/*output "env_file_name" {
  value = 
}
*/

# export the ecs task execution role arn 
output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}