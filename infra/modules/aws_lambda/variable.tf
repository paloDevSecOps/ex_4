variable "lambda_function_name" {
  type        = string
  description = "name of the lambda function"

}

variable "s3_bucket_name" {
  type        = string
  description = "name of s3 bucket"
}

variable "s3_bucket_key" {
  type        = string
  description = "key of the file in the bucket"
}

variable "handler" {
  type        = string
  description = "<module>.<handler_name>"
}

variable "runtime" {
  type        = string
  description = "runtime of the lambda function"
}

variable "root_proxy_rest_api_id" {
  type        = string
  description = "root proxy rest api id"
}

variable "root_proxy_resource_id" {
  type        = string
  description = "root proxy method resource id"
}

variable "root_proxy_http_method" {
  type        = string
  description = "root proxy method http method"
}

variable "rest_api_id" {
  type        = string
  description = "api gateway rest api id"
}

variable "resource_id" {
  type        = string
  description = "api gateway method resource id"
}

variable "http_method" {
  type        = string
  description = "api gateway method http method"
}

variable "api_gateway_execution_arn" {
  type        = string
  description = "api gateway execution arn"
}
