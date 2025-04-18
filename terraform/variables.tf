#General

variable "name" {
  description = "Resource Name"
  type        = string
  default     = "this"
}

variable "region" {
  description = "Region"
  type        = string
  default     = "eu-west-2"
}

variable "tags" {
  description = "Tags for Resources"
  type        = map(string)
  default     = {
    Environment = "dev",
    Project     = "eks",
    Owner       = "juned",
    Terraform   = "true"
}
}



#VPC

variable "vpc-cidr-block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "publicsubnet1-cidr-block" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "publicsubnet2-cidr-block" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}


variable "privatesubnet1-cidr-block" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = "10.0.3.0/24"
}


variable "privatesubnet2-cidr-block" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = "10.0.4.0/24"
}


#eks

variable "public-access-cidrs" {
  description = "range of ip's that can access the cluster"
  type        = string
  default     = "0.0.0.0/0"
}

variable "instance-disk-size" {
  description = "Disk size for instances"
  type        = number
  default     = 50
}

variable "instance-types" {
  description = "List of instance types to be used within the cluster"
  type        = list(string)
  default     = ["t3.medium"]
}


#route53

variable "domain_name" {
  description = "The domain name for the hosted zone"
  type        = string
  default     = "lab.juned.co.uk"
}