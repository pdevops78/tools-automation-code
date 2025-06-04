variable "tools" {
  default = {
    prometheus = {
      instance_type = "t2.micro"
    }
  }
}
variable "env"{}