# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Building from Ubuntu 14.04 32 bit base
  config.vm.box = "ubuntu/trusty32"

  # Adding a regnisable names to vagrant and the virtual machine
  config.vm.define "microbit-mupython-vg" do |t|
  end
  config.vm.provider "virtualbox" do |v|
    v.name = "microbit-mupython-vm"
  end

  # Boot with a GUI so you can see the screen. (Default is headless)
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

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  #config.vm.share_folder "v-root", "/home/vagrant/app-name", "", :nfs => true

  # Shell provision to install dependencies
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    echo "Installing git..."
    sudo apt-get update
    sudo apt-get -y install git
    echo "Installing extra python and pip..."
    sudo apt-get -y install python-setuptools python-dev python-pip python3-pip
    sudo pip install -U pip
    echo "Installing general build tools..."
    sudo apt-get -y install build-essential libreadline-dev libffi-dev libssl-dev libyaml-dev
    echo "Installing the compiler..."
    sudo apt-get remove binutils-arm-none-eabi gcc-arm-none-eabi
    sudo add-apt-repository ppa:terry.guo/gcc-arm-embedded
    sudo add-apt-repository -y ppa:pmiller-opensource/ppa
    sudo apt-get update
    sudo apt-get -y install cmake ninja-build gcc-arm-none-eabi=4.9.3.2015q3-1trusty1 srecord
    arm-none-eabi-gcc --version
    echo "Installing yotta..."
    sudo -H pip install yotta
    echo "Cloning MicroPython repository..."
    git clone https://github.com/bbcmicrobit/micropython.git
    echo "All done! execute 'vagrant ssh' to enter the virtual machine and continue the yotta"
    echo "configuration as defined in the README.md file, execute:"
    echo "  yt target bbc-microbit-classic-gcc-nosd"
    echo "  yt up"
    echo "  yt build"
  SHELL
end

