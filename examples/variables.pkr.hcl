//  variables.pkr.hcl

// For those variables that you don't provide a default for, you must
// set them from the command line, a var-file, or the environment.

variable "weekday" {}

variable "sudo_password" {
  type =  string
  default = "mypassword"
  // Sensitive vars are hidden from output as of Packer v1.6.5
  sensitive = true
}

variable "flavor" {
  type = string
  default = "strawberry"
}

variable "exit_codes" {
  type = list(number)
  default = [0]
}

locals {
  ice_cream_flavor = "${var.flavor}-ice-cream"
  foo             = "bar"
}