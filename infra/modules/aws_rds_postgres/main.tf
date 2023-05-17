resource "aws_db_instance" "postgres" {
  allocated_storage   = 5
  db_name             = var.db_name
  identifier          = var.db_identifier
  engine              = "postgres"
  engine_version      = "14.7"
  instance_class      = "db.t3.micro"
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
}
