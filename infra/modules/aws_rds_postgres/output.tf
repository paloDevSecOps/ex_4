output "hostname" {
  value = aws_db_instance.postgres.address
}
output "port" {
  value = aws_db_instance.postgres.port
}
output "username" {
  value = aws_db_instance.postgres.username
}
