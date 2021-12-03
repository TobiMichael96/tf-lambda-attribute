variable "project" {
  description = "Project name."
}

variable "stage" {
  description = "Stage name (e.g. dev, staging, prod)."
}

variable "region" {
  description = "AWS region."
}

variable "tags" {
  type        = map(any)
  description = "Additional tags."
}

variable "s3_buckets" {
  type        = list(any)
  description = "List of s3 bucket arns"
}