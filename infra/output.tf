output "api_gate_way_basic_info" {
  value = module.ex_4_api_gateway.api_gateway_basic_info
}

output "s3_basic_info" {
  value = module.ex_4_bucket.s3_basic_info
}

output "base_url" {
  value = aws_api_gateway_deployment.ex_4.invoke_url
}

# output "db_login" {
#   value = "psql -h ${module.db.hostname} -p ${module.db.port} -U ${module.db.username} postgres"
# }
