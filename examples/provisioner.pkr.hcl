build {
  # (source configuration omitted for brevity)

  provisioner "shell-local" {
    inline = ["echo 'Hello World' >example.txt"]
  }
  provisioner "file" {
    source      = "example.txt"
    destination = "/tmp/example.txt"
  }
  provisioner "shell" {
    inline = [
      "sudo install-something -f /tmp/example.txt",
    ]
  }
}