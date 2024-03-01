# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  if Vagrant.has_plugin? "vagrant-vbguest"
    config.vbguest.no_install  = true
    config.vbguest.auto_update = false
    config.vbguest.no_remote   = true
  end

  config.vm.define :serverWeb1 do |serverWeb1|
    serverWeb1.vm.box = "bento/ubuntu-22.04"
    serverWeb1.vm.network :private_network, ip: "192.168.100.3"
    serverWeb1.vm.hostname = "serverWeb1"
    serverWeb1.vm.provision "shell", path: "scriptServerNJS.sh", :args => "2 192.168.100.3 192.168.100.2"
  end

  config.vm.define :serverWeb2 do |serverWeb2|
    serverWeb2.vm.box = "bento/ubuntu-22.04"
    serverWeb2.vm.network :private_network, ip: "192.168.100.4"
    serverWeb2.vm.hostname = "serverWeb2"
    serverWeb2.vm.provision "shell", path: "scriptServerNJS.sh", :args => "2 192.168.100.4 192.168.100.2"
  end

  config.vm.define :haProxy do |haProxy|
    haProxy.vm.box = "bento/ubuntu-22.04"
    haProxy.vm.network :private_network, ip: "192.168.100.2"
    haProxy.vm.hostname = "haProxy"
    haProxy.vm.provision "shell", path: "scriptHAProxy.sh", :args => "192.168.100.2"
  end
end

