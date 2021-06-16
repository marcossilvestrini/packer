
variable "boot_wait" {
  type    = string
  default = "6s"
}

variable "disk_size" {
  type    = string
  default = "60000"
}

variable "iso_checksum" {
  type    = string
  default = "0394ecfa994db75efc1413207d2e5ac67af4f6685b3b896e2837c682221fd6b2"
}

variable "iso_url" {
  type    = string
  default = "http://mirror.globo.com/centos/8.4.2105/isos/x86_64/CentOS-8.4.2105-x86_64-dvd1.iso"
}

variable "memsize" {
  type    = string
  default = "1024"
}

variable "numvcpus" {
  type    = string
  default = "1"
}

variable "ssh_password" {
  type    = string
  default = "packer"
}

variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "vm_name" {
  type    = string
  default = "CentOS-8-x86_64-2021"
}

source "virtualbox-iso" "autogenerated_1" {
  boot_command     = ["e<down><down><end><bs><bs><bs><bs><bs>text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos8-ks.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  guest_os_type    = "RedHat_64"
  headless         = false
  http_directory   = "http"
  iso_checksum     = "${var.iso_checksum}"
  iso_interface    = "sata"
  iso_url          = "${var.iso_url}"
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = "${var.ssh_username}"
  vboxmanage       = [["modifyvm", "{{ .Name }}", "--memory", "${var.memsize}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.numvcpus}"], ["modifyvm", "{{ .Name }}", "--firmware", "EFI"]]
  vm_name          = "${var.vm_name}"
}

source "vmware-iso" "autogenerated_2" {
  boot_command     = ["e<down><down><end><bs><bs><bs><bs><bs>text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/centos8-ks.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_wait        = "${var.boot_wait}"
  disk_size        = "${var.disk_size}"
  disk_type_id     = "0"
  guest_os_type    = "centos-64"
  headless         = false
  http_directory   = "http"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = "${var.ssh_username}"
  vm_name          = "${var.vm_name}"
  vmx_data = {
    firmware            = "efi"
    memsize             = "${var.memsize}"
    numvcpus            = "${var.numvcpus}"
    "virtualHW.version" = "14"
  }
}

build {
  sources = ["source.virtualbox-iso.autogenerated_1"]

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = ["dnf -y update", "dnf -y install python3", "alternatives --set python /usr/bin/python3", "pip3 install ansible"]
  }

  /*
  provisioner "ansible-local" {
    playbook_file = "scripts/setup.yml"
  }

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = ["scripts/cleanup.sh"]
  }
  */

}
