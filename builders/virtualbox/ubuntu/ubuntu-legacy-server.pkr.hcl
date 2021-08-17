variable "memsize" {
  type    = string
  default = "8096"
}

variable "numvcpus" {
  type    = string
  default = "1"
}

variable "bridge_adapter" {
  type    = string
  default = "Marvell AQtion 5Gbit Network Adapter"
}

variable "preseed_file_name" {
  type    = string
  default = "preseed.cfg"
}

variable "output_directory"{
  type    = string
  default = "E://Servers/Virtualbox/packer-virtualbox-ubuntu-server-legacy-20.04"
}

variable "iso_url"{
  type    = string
  default = "F://ISOS/Linux/ubuntu-20.04.1-legacy-server-amd64.iso"
}

variable "iso_checksum"{
  type    = string
  default = "f11bda2f2caed8f420802b59f382c25160b114ccc665dbac9c5046e7fceaced2"
}

variable "ssh_host"{
  type    = string
  default = "192.168.0.133"
}

variable "ssh_username"{
  type    = string
  default = "provision"
}

variable "ssh_password"{
  type    = string
  default = "provision"
}

source "virtualbox-iso" "ubuntu-server" {
  boot_command     = ["<esc><wait>", "<esc><wait>", "<enter><wait>", "/install/vmlinuz<wait>", " initrd=/install/initrd.gz", " auto-install/enable=true", " debconf/priority=critical", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<wait>", " -- <wait>", "<enter><wait>"]
  boot_wait        = "10s"
  disk_size        = "60000"
  guest_os_type    = "Ubuntu_64"
  headless         = false
  http_directory   = "http"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  keep_registered  = "true"
  output_directory = "${var.output_directory}"
  shutdown_command = "echo 'provision'|sudo -S /sbin/halt -h -p"
  ssh_port         = 22
  ssh_timeout      = "20m"
  //ssh_host         = "${var.ssh_host}"
  ssh_username     = "${var.ssh_username}"
  ssh_password     = "${var.ssh_password}"
  vm_name          = "ubuntu-legacy-server-20.04-${legacy_isotime("2006-01-02")}"
  vboxmanage       = [
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

