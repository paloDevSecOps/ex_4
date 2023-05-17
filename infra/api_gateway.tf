resource "aws_api_gateway_rest_api" "ex_4_api_gateway" {
  name = var.api_gateway_name
}
resource "aws_api_gateway_resource" "test" {
  rest_api_id = aws_api_gateway_rest_api.ex_4_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.ex_4_api_gateway.root_resource_id
  path_part   = "test"
}
