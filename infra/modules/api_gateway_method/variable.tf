variable "rest_api_id" {
  type        = string
  description = "api gateway rest api id"
}
variable "parent_id" {
  type        = string
  description = "parent resource id"
}
variable "path_part" {
  type        = string
  description = "api path"
}
variable "method" {
  type        = string
  description = "http method"
}
variable "authorization" {
  type        = string
  description = "value"
  default     = "NONE"
}
