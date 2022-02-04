Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.provision "shell", path: "provision.sh"
  config.vm.network "forwarded_port", id: "docker", guest: 2375, host: 2375
end