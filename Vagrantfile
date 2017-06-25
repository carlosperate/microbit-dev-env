# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Building from Ubuntu 16.04 64 bit
  # Using alternative image, as the official has a bug with the ssh username and password:
  # https://bugs.launchpad.net/cloud-images/+bug/1569237
  config.vm.box = "ubuntu/trusty64"

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
    v.memory = mem_size > 0 ? mem_size : 2048
    cpu_count = ENV['VAGRANT_CPUS'].to_i
    v.cpus = cpu_count > 0 ? cpu_count: 1
  end

  # Create a forwarded port mapping which allows access to a specific port
  # This one is for running PXT HTTP port 3232 WS port 3233
  # Note that when you run `rails server`, you need to specify that it
  # bind to host 0.0.0.0, not localhost, or the port forwarding won't work.
  # pxt serve --hostname 0.0.0.0 --port 3232 --wsport 3233
  config.vm.network 'forwarded_port', guest: 3232, host: 3232, auto_correct: true
  config.vm.network 'forwarded_port', guest: 3233, host: 3233, auto_correct: true

  # Share an additional folders to the guest VM. The first argument is the path on the host to the
  # actual folder. The second argument is the path on the guest to mount the folder. And the
  # optional third argument is a set of non-required options.
  config.vm.synced_folder "vagrant_shared", "/home/vagrant/vagrant_shared"

  # Enable the creation of symlinks in the shared folder under Windows/macOs hosts
  config.vm.provider "virtualbox" do |v|
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant_shared", "1"]
  end

  # Example to copy file from repository root to shared folder in VM
  # config.vm.provision "file", source: "file.x", destination: "~/vagrant_shared/file.x"

  #
  # Comment in/out the lines below to enable/disable installing or downloading individual environments
  #
  # Install the tool chain required for PXT/MakeCode
  config.vm.provision "shell", privileged: false, path: "install_pxt_toolchain.sh"
  # Set up the PXT workspace for micro:bit
  config.vm.provision "shell", privileged: false, path: "setup_pxt_workspace.sh"
  # Install the tool chain required to compile C or C++ programs, and/or compile MicroPython
  config.vm.provision "shell", privileged: false, path: "install_cpp_toolchain.sh"
  # Download and compile the C++ examples (needs install_cpp_toolchain.sh to run first)
  config.vm.provision "shell", privileged: false, path: "build_cpp_source.sh"
  # Download and compile MicroPython (needs install_cpp_toolchain.sh to run first)
  config.vm.provision "shell", privileged: false, path: "build_micropython_source.sh"

  config.vm.post_up_message = "All done! execute 'vagrant ssh' to enter the virtual machine." \
                              "\n\tUsername: vagrant\n\tPassword: vagrant"
end
