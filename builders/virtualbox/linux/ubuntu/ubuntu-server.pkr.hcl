source "virtualbox-iso" "basic-example" {
  guest_os_type = "Ubuntu_64"
  iso_url = "http://releases.ubuntu.com/bionic/ubuntu-18.04.5-live-server-amd64.iso"
  iso_checksum = "md5:fcd77cd8aa585da4061655045f3f0511"
  ssh_username = "packer"
  ssh_password = "packer"
  boot_command = [
    "<tab><wait>",
    " ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ubuntu-ks.cfg<enter>"
 ]
 shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
}

build {
  sources = ["sources.virtualbox-iso.basic-example"]
}