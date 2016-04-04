# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
  ## IF you need to see the boot console in virtualbox, enable v.gui below:
    v.gui = true
  end

  config.vm.box = "ubuntu/trusty64" # ubuntu 14.04 LTS
  #   vb.memory = "1024"

  ## This bit gives the guest the specified mac address, so that my DHCP server will assign it the IP
  ## address I want assigned to it, and will provide DNS mapping to that IP:
  
  config.vm.network "public_network", bridge: [ # should appear on normal network
                      "en1: Wi-Fi (AirPort)",
                      "en0: Ethernet"
                    ], mac: "DEADBABE0001"
  
  config.vm.network "forwarded_port", guest: 32400, host: 32400
  
  config.vm.synced_folder "~/data_plex", "/data_plex"

  config.vm.provision "shell", path: "provision-plex.sh"
  config.vm.provision "shell", path: "provision-nginx.sh"

end
