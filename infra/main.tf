// ------ vpc and subnets
resource "aws_default_vpc" "default" {}

data "aws_availability_zones" "available_zones" {}

resource "aws_default_subnet" "subnet_az1" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]
}

resource "aws_default_subnet" "subnet_az2" {
  availability_zone = data.aws_availability_zones.available_zones.names[1]
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [aws_default_subnet.subnet_az1.id, aws_default_subnet.subnet_az2.id]
}
// ------ security groups
resource "aws_security_group" "lambda_security_group" {
  name        = "lambda security group"
  description = "enable http access on port 80"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_security_group" {
  name        = "database security group"
  description = "enable postgres access on port 5432"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.lambda_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}
// ------ db
module "db" {
  source                 = "./modules/aws_rds_postgres"
  db_name                = var.db_name
  db_identifier          = var.db_identifier
  db_username            = var.db_username
  db_password            = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_security_group.id]
  availability_zone      = data.aws_availability_zones.available_zones.names[0]
}

module "ex_4_bucket" {
  source      = "./modules/aws_s3"
  bucket_name = var.bucket_name
}

module "s3_lambdas" {
  for_each       = { for api in var.apis : api.api_name => api.api_name }
  source         = "./modules/aws_s3_object"
  s3_bucket_name = module.ex_4_bucket.s3_bucket_name
  s3_bucket_key  = each.value
  source_path    = "../api/bin/${each.value}.zip"
  depends_on     = [module.ex_4_bucket]
}

data "aws_iam_role" "lambda_exec" {
  name = "LambdaExecutionRole"
}

resource "aws_api_gateway_rest_api" "ex_4_api_gateway" {
  name = var.api_gateway_name
}
resource "aws_api_gateway_resource" "test" {
  rest_api_id = aws_api_gateway_rest_api.ex_4_api_gateway.id
  parent_id   = aws_api_gateway_rest_api.ex_4_api_gateway.root_resource_id
  path_part   = "test"
}

module "lambda_functions" {
  count                   = length(var.apis)
  source                  = "./modules/aws_lambda"
  lambda_function_name    = var.apis[count.index].api_name
  lambda_exec_role_arn    = data.aws_iam_role.lambda_exec.arn
  s3_bucket_name          = module.ex_4_bucket.s3_bucket_name
  s3_bucket_key           = var.apis[count.index].api_name
  handler                 = "index.handler"
  runtime                 = "nodejs18.x"
  rest_api_id             = aws_api_gateway_rest_api.ex_4_api_gateway.id
  resource_id             = aws_api_gateway_resource.test.id
  http_method             = var.apis[count.index].method
  integration_http_method = "POST"
  source_arn              = "${aws_api_gateway_rest_api.ex_4_api_gateway.execution_arn}/*/*"
  subnet_ids              = [aws_default_subnet.subnet_az1.id, aws_default_subnet.subnet_az2.id]
  security_group_ids      = [aws_security_group.lambda_security_group.id]
  depends_on              = [module.s3_lambdas]
}

resource "aws_api_gateway_deployment" "ex_4_dev" {
  depends_on  = [module.lambda_functions]
  rest_api_id = aws_api_gateway_rest_api.ex_4_api_gateway.id
  stage_name  = "dev"
}


