variable "memsize" {
  type        = string
  default     = "8096"
  description = "Resource of Memory"
}

variable "numvcpus" {
  type        = string
  default     = "1"
  description = "Resource of VCPUS"
}

variable "disk_size"{
  type        = string
  default     = "60000"
  description = "Size of Disk"
}

variable "bridge_adapter" {
  type        = string
  default     = "Marvell AQtion 5Gbit Network Adapter"
  description = "Default Phisical Adapter"
}

variable "iso_url"{
  type        = string
  default     = "F://ISOS/Linux/OracleLinux-R8-U4-x86_64-dvd.iso"
  description = "ISO URL - Local or http"
}

variable "iso_checksum"{
  type        = string
  default     = "a55e97eec90e8c810f23625a349af816e1fdf162428e2bf96b752ff562106d4b"
  description = "ISO Checksum - SHA256"
}

variable "output_directory"{
  type        = string
  default     = "E://Servers/Virtualbox/packer-virtualbox-ol8"
  description = "Output Build"
}

variable "ssh_host"{
  type        = string
  default     = "192.168.0.133"
  description = "SSH Ip for provisioner"
}

variable "ssh_username"{
  type        = string
  default     = "provision"
  description = "SSH Username for provisioner"
}

variable "ssh_password"{
  type        = string
  default     = "provision"
  description = "SSH password provisioner"
}