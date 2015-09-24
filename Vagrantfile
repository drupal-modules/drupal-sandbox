# -*- mode: ruby -*-
# vi: set ft=ruby :

API_VERSION = "2"
Vagrant.configure(API_VERSION) do |config|

  config.vm.box = "ubuntu/vivid64"
#config.vm.box_version = "20150722.0.0"
  config.vm.network "private_network", ip: "192.168.22.22"
  config.vm.hostname = "vagrant"
  config.vm.provision "shell", path: "scripts/provision.sh"
  config.vm.provision "shell", inline: "make -C /vagrant"
 #config.ssh.pty = true # Use pty for provisioning. Bug: https://github.com/mitchellh/vagrant/issues/6086
  config.ssh.forward_agent = true # Enables agent forwarding over SSH connections.
  config.ssh.forward_x11 = true # Enables X11 forwarding over SSH connections.
#config.hostmanager.enabled = true
#config.hostmanager.manage_host = true

  config.vm.synced_folder ".", "/vagrant", id: "core",
    nfs: true

  config.vm.provider "virtualbox" do |v|
    v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    v.memory = 2048
    v.cpus = 2
  end

end
