# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Building from Ubuntu 14.04 32 bit base
  config.vm.box = "ubuntu/trusty32"

  # Adding a recognisable names to vagrant and the virtual machine
  config.vm.define "microbit-vg" do |t|
  end
  config.vm.provider "virtualbox" do |v|
    v.name = "microbit-vm"
  end

  # Uncomment this line to boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign the virtual machine settings according to your host computer capabilities.
  # You can change the CPU count and memory size by exporting the following env var:
  #  VAGRANT_MEMORY_SIZE=x
  #  VAGRANT_CPUS=x
  config.vm.provider "virtualbox" do |v|
    mem_size = ENV['VAGRANT_MEMORY_SIZE'].to_i
    v.memory = mem_size > 0 ? mem_size : 1024
    cpu_count = ENV['VAGRANT_CPUS'].to_i
    v.cpus = cpu_count > 0 ? cpu_count: 1
  end

  # Share an additional folders to the guest VM. The first argument is the path on the host to the
  # actual folder. The second argument is the path on the guest to mount the folder. And the
  # optional third argument is a set of non-required options.
  config.vm.synced_folder "vagrant_shared", "/home/vagrant/vagrant_shared"

  # Shell provision to install dependencies, download and build source code
  config.vm.provision "shell", privileged: false, path: "install_compiler.sh"
  config.vm.provision "shell", privileged: false, path: "get_source_code.sh"
  config.vm.provision "shell", privileged: false, path: "build_source_code.sh"

  config.vm.post_up_message = "All done! execute 'vagrant ssh' to enter the virtual machine."
end
