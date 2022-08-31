variable "host_ingress_port_http" {
  type        = number
  description = "HTTP port number to use ingress"
  default     = 81
}

variable "host_ingress_port_ssh" {
  type        = number
  description = "SSH port number to use ingress"
  default     = 9443
}
