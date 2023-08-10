
#1. Create Security Group (With Outbound Rule Attached)
#1. Create Security Group (With Outbound Rule Attached) for ALB

resource "aws_security_group" "alb_sg" {
  name        = "ALB-${var.project_name}-SG"
  description = "Allow/Enable HTTP/HTTPS Access on Port 80/443 TLS inbound traffic Foe Application Load Balancer"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTP  Access -TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS Access-TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB-${var.project_name_b}-SG"
    Environment = "${var.env}-environment"
  }
}

resource "aws_security_group" "ssh_sg" {
  name        = "SSH-${var.project_name}-SG"
  description = "Allow/Enable SSH Access on Port 22 TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH  Access -TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_location}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSH-${var.project_name_b}-SG"
    Environment = "${var.env}-environment"
  }
}
#1. Create Security Group (With Inb--Outbound Rule Attached) for Web server
#Create Security Group Rule For Webserver/Container/ECS
resource "aws_security_group" "web_server_sg" {
  name        = "WEB-${var.project_name}-SG"
  description = "Allow/Enable HTTP/HTTPS Access on Port 80/443 via ALB and SSH on Port 22 via SSH SG"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "HTTP  Access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb_sg.id}"]
  }

  ingress {
    description     = "HTTPS Access"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb_sg.id}"]
  }

  ingress {
    description     = "SSH Access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ssh_sg.id}"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WEB-${var.project_name_b}-SG"
    Environment = "${var.env}-environment"
  }
}

#Create Security Group Rule For RDS Database
resource "aws_security_group" "database_sg" {
  name        = "RDS-${var.project_name}-SG"
  description = "Enable PostgreSQL Access on Port 5432"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "PostgreSQL Access"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["${aws_security_group.web_server_sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS-${var.project_name_b}-SG"
    Environment = "${var.env}-environment"
  }
}
