
output "vpc_id" {
  value = module.elearning.vpc_id
}

output "vpc_cidr" {
  value = module.elearning.vpc_cidr
}

output "public_subnets_id" {
  value = module.elearning.public_subnets_id
}

output "private_subnets_id" {
  value = module.elearning.private_subnets_id
}

output "alb_sg_id" {
  value = module.elearning.alb_sg_id
}
