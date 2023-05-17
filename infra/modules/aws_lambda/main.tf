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

resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_function_name
  s3_bucket     = var.s3_bucket_name
  s3_key        = var.s3_bucket_key

  handler = var.handler
  runtime = var.runtime

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_api_gateway_integration" "api_gateway_integration" {
  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = var.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_function.invoke_arn
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${var.api_gateway_execution_arn}/*/*"
}
