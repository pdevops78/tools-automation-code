variable "tools" {
  default = {
    prometheus = {
      instance_type = "t2.micro"
    }
    grafana = {
      instance_type = "t2.micro"
    }
    vault = {
      instance_type = "t2.micro"
    }
  }
}
variable "env"{}