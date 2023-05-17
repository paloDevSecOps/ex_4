variable "shared_credentials_files" {
  type        = list(string)
  description = "path to the shared credentials file"
}

variable "profile" {
  type        = string
  description = "profile name"
}

variable "api_gateway_name" {
  type        = string
  description = "name of the api gateway"
}

variable "lambda_function_name" {
  type        = string
  description = "name of the lambda function"
}


variable "bucket_name" {
  type        = string
  description = "name of the bucket"
}

variable "bucket_key" {
  type        = string
  description = "key of the file in the bucket"
}

variable "db_identifier" {
  type        = string
  description = "db identifier"
}

variable "db_username" {
  type        = string
  description = "db username"
}

variable "db_password" {
  type        = string
  description = "db password"
}

