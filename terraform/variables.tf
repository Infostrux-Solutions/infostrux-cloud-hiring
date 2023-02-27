variable "aws_assume_role" {
  type        = string
  description = "The ARN of the AWS role used to authenticate an AWS Account."
}

variable "code_repo" {
  type        = string
  description = "The name of the Github repo where the infrastructure is managed."
  default     = "infostrux-cloud-hiring"
}

variable "team" {
  type    = string
  default = "cloud-chapter"
}

variable "org_name" {
  type    = string
  default = "infostrux"
}
