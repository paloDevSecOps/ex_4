variable "lambda_function_name" {
  type = string
}
variable "s3_bucket_name" {
  type = string
}
variable "s3_bucket_key" {
  type = string
}
variable "handler" {
  type = string
}
variable "runtime" {
  type = string
}
variable "lambda_exec_role_arn" {
  type = string
}
variable "rest_api_id" {
  type = string
}
variable "resource_id" {
  type = string
}
variable "http_method" {
  type = string
}
variable "authorization" {
  type    = string
  default = "NONE"
}
variable "integration_http_method" {
  type = string
}
variable "source_arn" {
  type = string
}
