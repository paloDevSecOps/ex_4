output "api_gate_way_basic_info" {
  value = "Id: ${aws_api_gateway_rest_api.ex_4_api_gateway.id}\nRoot resource id: ${aws_api_gateway_rest_api.ex_4_api_gateway.root_resource_id}"
}

output "s3_basic_info" {
  value = module.ex_4_bucket.s3_basic_info
}

output "base_url" {
  value = aws_api_gateway_deployment.ex_4_dev.invoke_url
}

output "db_login_command" {
  value = "psql -h ${module.db.hostname} -p ${module.db.port} -U ${module.db.username} postgres"
}
