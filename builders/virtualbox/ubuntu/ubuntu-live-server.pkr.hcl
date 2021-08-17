variable "memsize" {
  type    = string
  default = "8096"
}

variable "numvcpus" {
  type    = string
  default = "2"
}

variable "bridge_adapter" {
  type    = string
  default = "Marvell AQtion 5Gbit Network Adapter"
}

variable "output_directory"{
  type    = string
  default = "E://Servers//Virtualbox//packer-virtualbox-ubuntu-live-server-21.04"
}

variable "iso_checksum" {
  type    = string
  default = "e4089c47104375b59951bad6c7b3ee5d9f6d80bfac4597e43a716bb8f5c1f3b0"
}

variable "iso_url" {
  type    = string
  default = "F://ISOS/Linux/ubuntu-21.04-live-server-amd64.iso"
}

variable "guest_additions_url" {
  type    = string
  default = ""
}

variable "headless" {
  type    = string
  default = "false"
}

# variable "ssh_host"{
#   type    = string
#   default = "192.168.0.133"
# }

variable "ssh_username"{
  type    = string
  default = "provision"
}

variable "ssh_password"{
  type    = string
  default = "provision"
}

locals {
  build_timestamp = "${legacy_isotime("20060102150405")}"
  http_directory  = "${path.root}/http"
}
source "virtualbox-iso" "ubuntu-server" {
  boot_command            = [" <wait>", " <wait>", " <wait>", " <wait>", " <wait>", "c", "<wait>", "set gfxpayload=keep", "<enter><wait>", "linux /casper/vmlinuz quiet<wait>", " autoinstall<wait>", " ds=nocloud-net<wait>", "\\;s=http://<wait>", "{{ .HTTPIP }}<wait>", ":{{ .HTTPPort }}/<wait>", " ---", "<enter><wait>", "initrd /casper/initrd<wait>", "<enter><wait>", "boot<enter><wait>"]
  boot_wait               = "5s"
  disk_size               = "60000"
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_additions_url     = "${var.guest_additions_url}"
  guest_os_type           = "Ubuntu_64"
  hard_drive_interface    = "sata"
  headless                = "${var.headless}"
  http_directory          = "${local.http_directory}"
  iso_checksum            = "${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  output_directory        = "${var.output_directory}"
  shutdown_command        = "echo 'provision' | sudo -S shutdown -P now"
  ssh_port                = 22
  ssh_timeout             = "10000s"
  //ssh_host                = "${var.ssh_host}"
  ssh_username            = "${var.ssh_username}"
  ssh_password            = "${var.ssh_password}"
  vm_name                 = "ubuntu-live-server-21.04-${legacy_isotime("2006-01-02")}"
  vboxmanage              = [
    //["modifyvm", "{{ .Name }}", "--firmware", "EFI"],
    ["modifyvm", "{{ .Name }}", "--spec-ctrl", "on"],
    ["modifyvm", "{{ .Name }}", "--triplefaultreset", "on"],
    ["modifyvm", "{{ .Name }}", "--hwvirtex", "on"],
    ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"],
    ["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"]
    //["modifyvm", "{{.Name}}", "--nic1", "bridged"],
    //["modifyvm", "{{.Name}}", "--bridgeadapter1", "${var.bridge_adapter}"],
    //["modifyvm", "{{.Name}}", "--cableconnected1", "on"]
  ]
}

build {
  sources = ["source.virtualbox-iso.ubuntu-server"]
  # provisioner "shell" {
  #   execute_command = "echo 'provision' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
  #   scripts         = ["scripts/foo.sh"]
  # }
}

