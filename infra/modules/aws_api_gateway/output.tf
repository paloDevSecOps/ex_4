output "api_gateway_basic_info" {
  value = "id: ${aws_api_gateway_rest_api.rest_api.id}; name: ${aws_api_gateway_rest_api.rest_api.name}; resource id: ${aws_api_gateway_rest_api.rest_api.root_resource_id}"
}

output "rest_api_id" {
  value = aws_api_gateway_rest_api.rest_api.id
}

output "method_resource_id" {
  value = aws_api_gateway_method.proxy.resource_id
}

output "method_http_method" {
  value = aws_api_gateway_method.proxy.http_method
}

output "execution_arn" {
  value = aws_api_gateway_rest_api.rest_api.execution_arn
}

output "root_proxy_resource_id" {
  value = aws_api_gateway_method.proxy_root.resource_id
}

output "root_proxy_http_method" {
  value = aws_api_gateway_method.proxy_root.http_method
}
