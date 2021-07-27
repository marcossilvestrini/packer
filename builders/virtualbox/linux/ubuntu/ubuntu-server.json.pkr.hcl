
source "vmware-iso" "ubuntu-20.04-legacy-server" {
  boot_command           = ["<esc><wait>", "<esc><wait>", "<enter><wait>", "/install/vmlinuz<wait>", " initrd=/install/initrd.gz", " auto-install/enable=true", " debconf/priority=critical", " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<wait>", " -- <wait>", "<enter><wait>"]
  boot_wait              = "5s"
  guest_os_type          = "ubuntu-64"
  http_directory         = "debian-installer/http"
  iso_checksum           = "f11bda2f2caed8f420802b59f382c25160b114ccc665dbac9c5046e7fceaced2"
  iso_checksum_type      = "sha256"
  iso_urls               = ["iso/ubuntu-20.04.1-legacy-server-amd64.iso", "http://cdimage.ubuntu.com/ubuntu-legacy-server/releases/20.04/release/ubuntu-20.04.1-legacy-server-amd64.iso"]
  memory                 = 1024
  output_directory       = "output/live-server"
  shutdown_command       = "shutdown -P now"
  ssh_handshake_attempts = "20"
  ssh_password           = "ubuntu"
  ssh_pty                = true
  ssh_timeout            = "20m"
  ssh_username           = "ubuntu"
}

build {
  sources = ["source.vmware-iso.ubuntu-20.04-legacy-server"]

  provisioner "shell" {
    inline = ["ls /"]
  }

}
