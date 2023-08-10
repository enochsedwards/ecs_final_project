variable "project_name" {
    default = "Technodemics"
}

#dynamo db
variable "dynamo_db_name" {
    default = "techno-state-lock"
}
variable "write_capacity" {
    default = "5"
}
variable "read_capacity" {
    default = "5"
}
