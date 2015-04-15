# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

# Set the Ansible configuration environment variable

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.network "private_network", ip: "192.168.111.223"
  config.vm.hostname = "happydev2012"

  config.vm.provider :virtualbox do |vb|
    vb.customize [
      'modifyvm', :id,
      '--memory', 1024,
      '--natdnshostresolver1', 'on',
      '--natdnsproxy1', 'on'
    ]
  end

  config.vm.synced_folder ".", "/app", type: "nfs"

  config.vm.network :forwarded_port, guest: 80, host: 3000
  config.vm.network :forwarded_port, guest: 3306,  host: 3306

  config.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "ansible/env/development"
    ansible.playbook = "ansible/provision.yml"
  end
end
