######### Creating RDS ##############
resource "aws_db_subnet_group" "education" {
  name       = "education"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "Education"
  }
}

resource "aws_db_parameter_group" "education" {
  name   = "education"
  family = "mysql5.7"
}

resource "aws_db_instance" "rdsinstance" {
    identifier             = "education"
    allocated_storage    = 20
    max_allocated_storage= 40
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t2.micro"
    name                 = "mydb"
    username             = "admin"
    password             = "abcd1234"
    db_subnet_group_name = aws_db_subnet_group.education.name
  #parameter_group_name  = "default.mysql5.7"
    parameter_group_name = aws_db_parameter_group.education.name
    auto_minor_version_upgrade = true
    vpc_security_group_ids = [aws_security_group.rdssecure.id]
    publicly_accessible    = true
    skip_final_snapshot  = true
    port = 3306
 }
