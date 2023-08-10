# Creating RDS Datebase
resource "aws_db_subnet_group" "database_subnet_group" {
  name = var.database_subnets
  /*subnet_ids = [aws_subnet.private_subnets[0].id, aws_subnet.private_subnets[1].id]*/
  subnet_ids = aws_subnet.private_subnets.*.id
  tags = {
    Name = "${var.project_name_b}-db_subnets"
    Environment = "${var.env}-environment"
  }
}

# create the rds instance
resource "aws_db_instance" "db_instance" {
  engine                 = var.engine
  engine_version         = var.engine_version
  multi_az               = var.multi_az
  identifier             = var.identifier
  username               = var.username
  password               = var.password
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database_sg.id]
  availability_zone      = var.availability_zone_db
  /*availability_zone      = var.availability_zone[count.index]
  availability_zone      = [aws_subnet.private_subnets[1].id]*/
  db_name             = var.db_name
  skip_final_snapshot = var.skip_final_snapshot
}

