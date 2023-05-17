# module "main_vpc" {
#   source         = "./modules/vpc"
#   vpc_cidr_block = "10.0.0.0/16"
# }

# module "ex_4_api_gateway" {
#   source           = "./modules/aws_api_gateway"
#   api_gateway_name = var.api_gateway_name
# }

module "ex_4_bucket" {
  source      = "./modules/aws_s3"
  bucket_name = var.bucket_name
}
# module "s3_root_lambda" {
#   source         = "./modules/aws_s3_object"
#   s3_bucket_name = module.ex_4_bucket.s3_bucket_name
#   s3_bucket_key  = "getExample"
#   source_path    = "../api/bin/getExample.zip"
#   depends_on     = [module.ex_4_bucket]
# }
module "s3_lambdas" {
  for_each       = { for api in var.apis : api.api_name => api.api_name }
  source         = "./modules/aws_s3_object"
  s3_bucket_name = module.ex_4_bucket.s3_bucket_name
  s3_bucket_key  = each.value
  source_path    = "../api/bin/${each.value}.zip"
  depends_on     = [module.ex_4_bucket]
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_policy"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : ""
          "Principal" : {
            "Service" : "lambda.amazonaws.com"
          },
          "Effect" : "Allow",
          "Action" : "sts:AssumeRole",
        }
      ]
    }
  )
}

# module "db" {
#   source        = "./modules/aws_rds_postgres"
#   db_name       = var.db_name
#   db_identifier = var.db_identifier
#   db_username   = var.db_username
#   db_password   = var.db_password

# }
# module "root_lambda" {
#   source                  = "./modules/aws_lambda"
#   lambda_function_name    = "helloWorld"
#   lambda_exec_role_arn    = aws_iam_role.lambda_exec.arn
#   s3_bucket_name          = module.ex_4_bucket.s3_bucket_name
#   s3_bucket_key           = "getExample"
#   handler                 = "index.handler"
#   runtime                 = "nodejs18.x"
#   rest_api_id             = aws_api_gateway_rest_api.ex_4_api_gateway.id
#   resource_id             = aws_api_gateway_method.proxy_root.resource_id
#   http_method             = aws_api_gateway_method.proxy_root.http_method
#   integration_http_method = "POST"
#   source_arn              = "${aws_api_gateway_rest_api.ex_4_api_gateway.execution_arn}/*/*"
#   depends_on              = [module.s3_root_lambda]
# }

module "lambda_functions" {
  count                   = length(var.apis)
  source                  = "./modules/aws_lambda"
  lambda_function_name    = var.apis[count.index].api_name
  lambda_exec_role_arn    = aws_iam_role.lambda_exec.arn
  s3_bucket_name          = module.ex_4_bucket.s3_bucket_name
  s3_bucket_key           = var.apis[count.index].api_name
  handler                 = "index.handler"
  runtime                 = "nodejs18.x"
  rest_api_id             = aws_api_gateway_rest_api.ex_4_api_gateway.id
  resource_id             = aws_api_gateway_resource.test.id
  http_method             = var.apis[count.index].method
  integration_http_method = "POST"
  source_arn              = "${aws_api_gateway_rest_api.ex_4_api_gateway.execution_arn}/*/*"
  depends_on              = [module.s3_lambdas]
}

resource "aws_api_gateway_deployment" "ex_4_dev" {
  depends_on  = [module.lambda_functions]
  rest_api_id = aws_api_gateway_rest_api.ex_4_api_gateway.id
  stage_name  = "dev"
}


