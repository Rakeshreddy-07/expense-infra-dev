variable "project" {
    default = "expense"
  
}

variable "environment" {
    default = "dev"
  
}

variable "common_tags" {
    default = {
        Terraform = "True"
        Test = "Practice"
    }
  
}

variable "bastion_tags" {
    default = {
        Purpose = "Practice"
    }
  
}

variable "zone_id" {
    default = "Z07890142HXNMPPOLRJE3"
  
}

variable "domain_name" {
    default = "devopsaws82s.online"
  
}