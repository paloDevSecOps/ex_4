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
variable "db_subnet_group_name" {
  type        = string
  description = "name of the db subnet group"
}
variable "vpc_security_group_ids" {
  type = set(string)
}
variable "availability_zone" {
  type = string
}
