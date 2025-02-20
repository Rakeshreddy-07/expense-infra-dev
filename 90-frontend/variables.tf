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

variable "domain_name" {
    default = "devopsaws82s.online"
  
}