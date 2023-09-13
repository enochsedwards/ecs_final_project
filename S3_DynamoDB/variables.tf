variable "project_name" {
    default = "technodemics"
}

#dynamo db
/*variable "dynamo_db_name" {
    default = "techno-state-lock"
}*/

variable "write_capacity" {
    default = "20"
}
variable "read_capacity" {
    default = "20"
}
