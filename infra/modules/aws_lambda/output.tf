output "lamba_basic_info" {
  value = "id: ${aws_lambda_function.lambda_function.id}; name: ${aws_lambda_function.lambda_function.function_name}; arn: ${aws_lambda_function.lambda_function.arn}; role: ${aws_lambda_function.lambda_function.role}"
}

output "invoke_arn" {
  value = aws_lambda_function.lambda_function.invoke_arn
}

output "function_name" {
  value = aws_lambda_function.lambda_function.function_name
}
