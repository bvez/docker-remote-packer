packer {
  required_plugins {
    vagrant = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

source "vagrant" "docker_remote_box" {
  communicator = "ssh"
  source_path  = "ubuntu/bionic64"
  provider     = "virtualbox"
  insert_key   = true
}

build {
  sources = ["source.vagrant.docker_remote_box"]

  provisioner "shell" {
    script = "docker-remote/provision.sh"
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
  }
}