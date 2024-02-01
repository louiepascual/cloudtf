variable "aws_access_key" {
    type        = string
    description = "AWS access key"
}

variable "aws_secret_key" {
    type        = string
    description = "AWS secret key"
}

variable "aws_region" {
    type        = string
    description = "AWS region"
}

variable "aws_ssh_key" {
    type        = string
    description = "Public key to use for SSH"
}

variable "aws_allowed_ips" {
    type        = list(string)
    description = "List of allowed IPs in CIDR notation"
    default     = ["0.0.0.0/0"]
}
