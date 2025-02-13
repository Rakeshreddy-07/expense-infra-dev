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
