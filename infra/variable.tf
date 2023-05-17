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

variable "apis" {
  type = list(object({
    api_name = string
    method   = string
  }))
}
variable "db_identifier" {
  type        = string
  description = "db identifier"
}
variable "db_name" {
  type        = string
  description = "name of the database"
}
variable "db_username" {
  type        = string
  description = "name of the user accessing the database"
}
variable "db_password" {
  type        = string
  description = "password of the user"
}
