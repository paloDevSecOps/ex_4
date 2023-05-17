module "ex_4_api_gateway" {
  source           = "./modules/aws_api_gateway"
  api_gateway_name = var.api_gateway_name
}

module "ex_4_bucket" {
  source      = "./modules/aws_s3"
  bucket_name = var.bucket_name
}

module "s3_object" {
  source         = "./modules/aws_s3_object"
  s3_bucket_name = module.ex_4_bucket.s3_bucket_name
  s3_bucket_key  = var.bucket_key
  source_path    = "../api/bin/getExample.zip"
  depends_on     = [module.ex_4_bucket]
}




module "lambda_getExample" {
  source                    = "./modules/aws_lambda"
  lambda_function_name      = "getExample"
  s3_bucket_name            = module.ex_4_bucket.s3_bucket_name
  s3_bucket_key             = var.bucket_key
  handler                   = "index.handler"
  runtime                   = "nodejs18.x"
  rest_api_id               = module.ex_4_api_gateway.rest_api_id
  resource_id               = module.ex_4_api_gateway.method_resource_id
  http_method               = module.ex_4_api_gateway.method_http_method
  api_gateway_execution_arn = module.ex_4_api_gateway.execution_arn
  depends_on                = [module.s3_object]
}

resource "aws_api_gateway_deployment" "ex_4_dev" {
  depends_on = [module.lambda_getExample]

  rest_api_id = module.ex_4_api_gateway.rest_api_id
  stage_name  = "dev"
}


