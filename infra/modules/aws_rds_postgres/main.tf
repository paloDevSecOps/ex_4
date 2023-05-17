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

# resource "aws_security_group_rule" "ingress" {
#   type              = "ingress"
#   from_port         = 5432
#   to_port           = 5432
#   protocol          = "tcp"
#   security_group_id = aws_security_group.name.id
# }
# resource "aws_security_group_rule" "egress" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   security_group_id = aws_security_group.name.id


# }

# resource "aws_security_group" "name" {

# }
