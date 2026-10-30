variable "region" {
  description = "The region where the resources are created."
  default     = "ap-southeast-1"
}

variable "frontend_prefix" {
  description = "The prefix for the frontend resources."
  default     = "frontend"
}

variable "frontend_environment" {
  description = "The environment for the frontend resources."
  default     = "fontend_env"
}

variable "organization" {
  description = "The organization of vpc-peering-project"
  default     = "minmyatko"
}

variable "frontend_network_workspace" {
  description = "The frontend network worksapce of vpc-peering-project"
  default     = "fe-network-ws"
}

variable "frontend_security_workspace" {
  description = "The frontend security worksapce of vpc-peering-project"
  default     = "fe-security-ws"
}

variable "frontend_compute_workspace" {
  description = "The frontend security worksapce of vpc-peering-project"
  default     = "fe-compute-ws"
}


variable "backend_network_workspace" {
  description = "The backend network worksapce of vpc-peering-project"
  default     = "be-network-ws"
}

variable "backend_security_workspace" {
  description = "The backend security worksapce of vpc-peering-project"
  default     = "be-security-ws"
}


variable "backend_compute_workspace" {
  description = "The backend security worksapce of vpc-peering-project"
  default     = "be-compute-ws"
}

variable "backend_private_subnet_cidr" {
  description = "The CIDR block for the backend private subnets."
  default     = ["192.168.253.0/24", "192.168.254.0/24", "192.168.255.0/24"]
}

variable "frontend_private_subnet_cidr" {
  description = "The CIDR block for the frontend private subnets."
  default     = ["10.0.253.0/24", "10.0.254.0/24", "10.0.255.0/24"]
}

# variable "be_security_group_id" {
#   description = "prviate_sg_02_id and private_sg_03_id from backend"
#   default     = ["sg-0b0cbcd32c51b8c3d","sg-0e7284fc9e951e63f"]
# }


# variable "fe_security_group_id" {
#   description = "prviate_sg_02_id and private_sg_03_id from frontend"
#   default     = ["sg-06a24fbb6e05047e3","sg-0ce38aa6f81839582"]
# }
