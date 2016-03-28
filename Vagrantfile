# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64" # ubuntu 14.04 LTS
  config.vm.network "public_network" # should appear on normal network
  config.vm.synced_folder "data_plex", "/data_plex"
  #   vb.memory = "1024"
  config.vm.provision "shell", path: "provision.sh"
end
