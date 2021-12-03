variable "owner" {
  default = "terraform"
}

variable "project" {
  description = "Project name."
}

variable "stage" {
  description = "Stage name (e.g. dev, staging, prod)."
}

variable "region" {
  description = "AWS region."
}