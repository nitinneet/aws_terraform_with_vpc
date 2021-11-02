########### Creating SG for RDS ###############
resource "aws_security_group" "rdssecure" {
    name        = "rds-secure"
    description = "Allow TLS inbound traffic"
    vpc_id      = module.vpc.vpc_id

ingress {
    description = "Database"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {

    description = "HTTP"
    from_port   = 80
    to_port     = 80
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
    Name = "rds"
 }
}

############ Creating EKS security_groups ################
resource "aws_security_group" "secure" {
    name        = "eks-secure"
    description = "Allow TLS inbound traffic"
    vpc_id      = module.vpc.vpc_id

ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    description = "HTTPS"
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
    Name = "kubernetes"
    }
}
