# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  servers = [
    {
      id: :db1,
      ip: "172.16.2.111",
      hostname: "db1"
    }
  ]

  servers.each do |server_settings|
    config.vm.define server_settings[:id] do |box|

      box.vm.box = "precise64"
      box.vm.hostname = server_settings[:hostname]
      box.vm.network :private_network, ip: server_settings[:ip]

      box.vm.network :forwarded_port, guest: 80, host: 8080
      box.vm.network :forwarded_port, guest: 5432, host: 5432

      box.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "default.pp"
        puppet.module_path = "modules"
      end

    end
  end
end
