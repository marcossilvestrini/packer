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

source "virtualbox-iso" "oracle-linux-8" {
  boot_command            = ["e<down><down><end><bs><bs><bs><bs><bs>text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_wait               = "10s"
  disk_size               = "60000"
  hard_drive_interface    = "sata"
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "RedHat_64"
  headless                = false
  http_directory          = "http"
  iso_checksum            = "${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  keep_registered         = "true"
  output_directory        = "${var.output_directory}"
  shutdown_command        = "echo 'provision'|sudo -S /sbin/halt -h -p"
  ssh_port                = 22
  ssh_timeout             = "20m"
  ssh_host                = "${var.ssh_host}"
  ssh_username            = "${var.ssh_username}"
  ssh_password            = "${var.ssh_password}"
  vm_name                 = "ol8-${legacy_isotime("2006-01-02")}"
  vboxmanage              = [
    ["modifyvm", "{{ .Name }}", "--firmware", "EFI"],
    ["modifyvm", "{{ .Name }}", "--spec-ctrl", "on"],
    ["modifyvm", "{{ .Name }}", "--triplefaultreset", "on"],
    ["modifyvm", "{{ .Name }}", "--hwvirtex", "on"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"],
    ["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"],
    ["modifyvm", "{{.Name}}", "--nic2", "bridged"],
    ["modifyvm", "{{.Name}}", "--bridgeadapter2", "${var.bridge_adapter}"],
    ["modifyvm", "{{.Name}}", "--cableconnected2", "on"]
  ]
}
build {
  sources = ["source.virtualbox-iso.oracle-linux-8"]
  # provisioner "shell" {
  #   execute_command = "echo 'provision' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
  #   scripts         = ["scripts/foo.sh"]
  # }
}

