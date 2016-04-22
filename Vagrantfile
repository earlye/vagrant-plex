# -*- mode: ruby -*-
# vi: set ft=ruby :

def get_machine_id()
  machine_id_filepath = ".vagrant/machines/default/virtualbox/id"

  if not File.exists? machine_id_filepath
    # VM hasn't been created yet.
    return false
  end

  # This is probably not a great way to do this: shell out to the cat command.
  # It seems likely that ruby has a get-file-contents function somewhere,
  # but I'm definitely not a ruby dev right now.
  machine_id = `cat #{machine_id_filepath}`
end

def usbfilter_exists(serial_number)
  #
  # Determine if a usbfilter with the provided Vendor/Product ID combination
  # already exists on this VM.
  #
  # TODO: Use a more reliable way of retrieving this information.
  #
  # NOTE: The "machinereadable" output for usbfilters is more
  #       complicated to work with (due to variable names including
  #       the numeric filter index) so we don't use it here.
  #
  # Plagiarized from: https://github.com/mitchellh/vagrant/issues/5774
  #
  # Modified to use serial number based filters rather than manufacturer/productId

  machine_id = get_machine_id()

  vm_info = `VBoxManage showvminfo --machinereadable #{machine_id}`

  filter_match = /USBFilterSerialNumber[0-9]*="#{serial_number}"/
  result = !(filter_match !~ vm_info)
  return result
end

def better_usbfilter_add(vb, serialnumber, filter_name)
  #
  # This is a workaround for the fact VirtualBox doesn't provide
  # a way for preventing duplicate USB filters from being added.
  #
  # TODO: Implement this in a way that it doesn't get run multiple
  #       times on each Vagrantfile parsing.
  #
  # Plagiarized from: https://github.com/mitchellh/vagrant/issues/5774
  #
  # Modified to use serial number based filters rather than manufacturer/productId

  if not usbfilter_exists(serialnumber)
    vb.customize ["usbfilter", "add", "0",
                  "--target", :id,
                  "--name", filter_name,
                  "--serialnumber", serialnumber ]
  end
end

Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.memory = "2048"

    #
    # All of my plex media is on a usb drive with the serial number below.
    #
    # This requires the VirtualBox usb extension pack, available here:
    # https://www.virtualbox.org/wiki/Downloads
    #
    # Note that the vbox version in the vagrant, at the time I wrote
    # this, is 4.3.36, so you need to grab that extension.  On the
    # host: 
    #
    # $ curl -o Oracle_VM_VirtualBox_Extension_Pack-4.3.36-105129.vbox-extpack \
    #   http://download.virtualbox.org/virtualbox/4.3.36/Oracle_VM_VirtualBox_Extension_Pack-4.3.36-105129.vbox-extpack
    #
    # $ VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.3.36-105129.vbox-extpack
    # 
    v.customize ["modifyvm", :id, "--usb", "on"]
    v.customize ["modifyvm", :id, "--usbehci", "on"]
    better_usbfilter_add(v,"57584731453635395639574E","plex-drive")
  end

  config.vm.box = "ubuntu/trusty64" # ubuntu 14.04 LTS
  config.vm.hostname = "plex"

  ## This bit gives the guest the specified mac address, so that my DHCP server will assign it the IP
  ## address I want assigned to it, and will provide DNS mapping to that IP:
  config.vm.network "public_network", 
  bridge: [ "eth0" ],  # should appear on normal network
  mac: "DEADBABE0001"
  
  config.vm.network :forwarded_port, guest: 32400, host: 32400
  config.vm.network :forwarded_port, guest: 22, host: 2224, id: "ssh"
  
  config.vm.provision "shell", path: "provision-plex.sh"
  config.vm.provision "shell", path: "provision-nginx.sh"

  ## I used to use synced_folders, but it turns out this is pretty slow
  ## compared to just mounting the USB drive directly.
  # config.vm.synced_folder "/mnt/plex", "/mnt/plex"
end
