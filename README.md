# BBC micro:bit MicroPython Development Environment
This is Vagrant script to facilitate the development of MicroPython for the BBC micro:bit.

This takes care of creating a virtual machine with all the development tools install and ready to be used.


## Prerequisites
You will need to have the following first:

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* An [mbed account](https://www.mbed.com/)


## Installing
Clone, or [download]() this repository, maybe with a shorter folder name:

```bash
git clone https://github.com/carlosperate/microbit-micropython-dev-env.git microbit-dev
cd microbit-dev
```

Getting the virtual machine up and running with Vagrant is extremelly easy:

```bash
vagrant up
```

This will download the Ubuntu 14.04 32 bit virtual box image, so it might take a while depending on your internet connection.


## Usage
Once you have the Vagrant box up and running, ensure it is up (with `vagrant up`) and ssh into it:

```bash
vagrant ssh
```

The MicroPython code is already there, but before you can compile it the yotta will need you to login and fetch assets:

```bash
cd micropython
yt target bbc-microbit-classic-gcc-nosd
yt up
yt build
```

