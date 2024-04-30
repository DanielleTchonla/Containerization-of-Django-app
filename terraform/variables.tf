variable "vpc_CIDR" {
    default = "10.0.0.0/16"
    description = "CIDR block for VPC"
    type = string
}

variable "key_name" {
    default = "Virginia-key"
    description = "key name for SSH"
    type = string
}

  
  