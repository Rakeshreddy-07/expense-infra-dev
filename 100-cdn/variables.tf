variable "project" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
    }
}


variable "zone_id" {
    default = "Z07890142HXNMPPOLRJE3"
}

variable "domain_name" {
    default = "devopsaws82s.online"
}