resource "aws_db_instance" "postgres" {
  allocated_storage      = 5
  db_name                = var.db_name
  identifier             = var.db_identifier
  engine                 = "postgres"
  engine_version         = "14.7"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  multi_az               = false
  publicly_accessible    = true
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  availability_zone      = var.availability_zone
}
