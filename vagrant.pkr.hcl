variable "cloud_token" {
  type    = string
  default = "${env("VAGRANT_CLOUD_TOKEN")}"
}

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

  post-processor "vagrant-cloud" {
    access_token = "${var.cloud_token}"
    box_tag      = "bvez/docker-remote"
    version      = "1.0"
  }
}