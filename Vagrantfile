# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Building from Ubuntu 16.04 64 bit
  config.vm.box = "ubuntu/xenial64"

  # This Ubuntu image creates a ubuntu-xenial-16.04-cloudimg-console.log file
  #   https://betacloud.io/get-rid-of-ubuntu-xenial-16-04-cloudimg-console-log/
  config.vm.provider "virtualbox" do |vb|
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
  end

  # Adding a recognisable names to vagrant and the virtual machine
  config.vm.define "microbit-vg" do |t|
  end
  config.vm.provider "virtualbox" do |v|
    v.name = "microbit-vm"
  end

  # Uncomment this line to boot with a GUI (default is headless).
  # config.vm.boot_mode = :gui

  # Assign the VM settings according to your host computer capabilities. You can
  # change the CPU count and memory by setting these environmental variables:
  #   VAGRANT_MEMORY_SIZE=x
  #   VAGRANT_CPUS=x
  config.vm.provider "virtualbox" do |v|
    mem_size = ENV['VAGRANT_MEMORY_SIZE'].to_i
    v.memory = mem_size > 0 ? mem_size : 2048
    cpu_count = ENV['VAGRANT_CPUS'].to_i
    v.cpus = cpu_count > 0 ? cpu_count : 1
    # Display or hide the VirtualBox GUI when booting the machine
    v.gui = false
    # Enable USB and pass through the micro:bit
    # It is more effective to plug-in the device when the vm is already running
    # v.customize ["modifyvm", :id, "--usb", "on"]
    # v.customize ["modifyvm", :id, "--usbehci", "on"]
    # v.customize ["usbfilter", "add", "0", "--target", :id,
    #              "--name", "BBC micro:bit",
    #              "--vendorid", "0x0D28", "--productid", "0x0204"]
  end

  # Create a forwarded port mapping which allows access to a specific port.
  # This one is for running PXT HTTP port 3232 WS port 3233.
  # Note that when you run a VM local server you need to specify that it binds
  # to host 0.0.0.0, not localhost, or the port forwarding won't work.
  #   pxt serve --hostname 0.0.0.0 --port 3232 --wsport 3233
  config.vm.network 'forwarded_port', guest: 3232, host: 3232, auto_correct: true
  config.vm.network 'forwarded_port', guest: 3233, host: 3233, auto_correct: true

  # Share an additional folders to the guest VM. The first argument is the path
  # on the host to the actual folder. The second argument is the path on the
  # guest to mount the folder. And the optional third argument is a set of
  # non-required options.
  config.vm.synced_folder "vagrant_shared", "/home/vagrant/vagrant_shared"

  # Enable creation of symlinks in the shared folder under Windows/macOS hosts
  config.vm.provider "virtualbox" do |v|
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant_shared", "1"]
  end

  # Example to copy file from repository root to shared folder in VM
  # config.vm.provision "file", source: "file.x", destination: "~/vagrant_shared/file.x"

  # Fix to an issue with setting up locales in the Ubuntu VM
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    sudo apt-get install -y language-pack-en
  SHELL


  # Everything below will need the GCC ARM compiler and yotta, so do not exclude
  config.vm.provision "shell", privileged: false, path: "scripts/install_gcc-arm.sh"
  config.vm.provision "shell", privileged: false, path: "scripts/install_yotta.sh"

  ##############################################################################
  #                                                                            #
  # Comment in/out the lines below to enable/disable installing tool chains.   #
  #                                                                            #
  ##############################################################################
  # Install tool chain for PXT/MakeCode
  config.vm.provision "shell", privileged: false, path: "scripts/install_toolchain_pxt.sh"
  # Install tool chain for C/C++ DAL programs (including MicroPython)
  config.vm.provision "shell", privileged: false, path: "scripts/install_toolchain_cpp.sh"

  ##############################################################################
  #                                                                            #
  # Comment in/out the lines below to download & build individual environments #
  #                                                                            #
  ##############################################################################
  # Set up the PXT workspace for micro:bit   (requires install_pxt_toolchain.sh)
  config.vm.provision "shell", privileged: false, path: "scripts/build_pxt.sh"
  # Download and compile C++ DAL examples    (requires install_cpp_toolchain.sh)
  config.vm.provision "shell", privileged: false, path: "scripts/build_cpp.sh"
  # Download and compile MicroPython         (requires install_cpp_toolchain.sh)
  config.vm.provision "shell", privileged: false, path: "scripts/build_upy.sh"


  config.vm.post_up_message = "All done! execute 'vagrant ssh' to enter the " \
                              "virtual machine.\n\t" \
                              "Username: vagrant\n\tPassword: vagrant"
end
