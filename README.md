# BBC micro:bit C/C++, MakeCode and MicroPython Development Environment
This repository contains a Vagrant box configured to facilitate the development of MicroPython, MakeCode, and C/C++ programs for the BBC micro:bit.

[Vagrant](https://www.vagrantup.com/intro/index.html) is a tool to easily build and manage virtual machine environments.

This very easy to use virtual machine contains everything you need to:

* Build micro:bit MicroPython from source
	* And load Python scripts using your own built MicroPython
* Run a local version of MakeCode/PXT
* Develop your own MakeCode packages
* Build C/C++ applications for the micro:bit

With a single command this project takes care of creating a virtual machine, installing all the development tools and dependencies required, download all the source code, compile everything, and get it ready for use. It offers a replicable development environment that is independent of your operating system, working the same way under Windows, macOS, or Linux.


Table of contents:
* [Install](#install)
* [Access the virtual machine](#access-the-virtual-machine)
* [Workflow](#workflow)
* [Environments](#environments)
	* [MicroPython](#micropython)
	* [MakeCode](#makecode)
	* [C/C++](#cc)
* [License](#license)
* [Trademarks](#trademarks)


## Install

### Prerequisites
You will need the following applications first:

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* (Optional)[Python](https://www.python.org/)

### Vagrant Project Bring-up

Clone, or [download](https://github.com/carlosperate/microbit-dev-env.git) this repository:

```bash
git clone https://github.com/carlosperate/microbit-dev-env.git
cd microbit-dev-env
```

Getting the virtual machine up and running with Vagrant is extremely easy, on the Command Line Interface just run:

```bash
vagrant up
```

This will download an Ubuntu 16.04 64 bit virtual box image, so it might take a while depending on your internet connection. It will also install the tool-chain, download and build all the source code for the different projects, ensuring everything is ready to develop your application in any of these platforms.


## Access the Virtual Machine
Once you have the Vagrant box up and running (`vagrant up` command), you can SSH with Vagrant:

```bash
vagrant ssh
```

Or with your preferred SSH client:

```
Host: 127.0.0.1
Port: 2222
Username: vagrant
Password: vagrant
```

This will give you command line access to the virtual machine, allowing you to compile the source code contained in the `vagrant_shared` folder. By default you will find the `cpp-samples`, `micropython`, `pxt-workspace` and a couple of extra folders there, which can be accessed from the virtual machine to build the projects. So within the SSH connection you can:

```bash
cd vagrant_shared/micropython
yt build
```

To close the virtual machine from running on the background, you can use the following command on the host:

```
vagrant halt
```

More information can be found in the [Vagrant documentation](https://www.vagrantup.com/docs/).


## Workflow
The general workflow concept is to have one folder that is accessible by both the host operating system (your computer), and the virtual machine.

This allows you to create and edit your code like you would normally do (using any IDE or editor you prefer), and then use the virtual machine to compile it there.

So, at the top level of the project directory you will find the `vagrant_shared` folder, a shared folder between host operating system and guest virtual machine. The virtual machine location for this folder is `~/vagrant_shared` and this is where the source code and projects live.

The `vagrant_shared` directory has been gitignored, so feel free to add your own repositories there without interference from this one.


## Environments

### C/C++
##### Project/code location
There are two C/C++ projects:
* [microbit samples](https://github.com/lancaster-university/microbit-samples): A collection of example programs using the micro:bit runtime (DAL).
	```
	vagrant_shared/cpp-samples/
	```
* [C++ template for DAL v1](https://github.com/carlosperate/microbit-dal-v1-cpp-template): Simple hello world program template using an older version of the micro:bit runtime/DAL (v1.4.x). The DAL version used here is the same as the version in MicroPython, so it's only useful for cases where you might need to test something for MicroPython development.
	```
	vagrant_shared/cpp-template-dal-v1/
	```

##### Building
Both C/C++ projects have already been built, but if you wish to recompile the examples you can access the virtual machine via SSH and within the project directory run:

```bash
yt clean
yt build
```

The `microbit samples` source/examples folder contains a selection of samples demonstrating the capabilities and usage of the runtime APIs. To select a sample, simply copy the .cpp files from the relevant folder into the `microbit_samples/source/` folder.

##### Built output locations

* microbit samples: `vagrant_shared/cpp-samples/build/bbc-microbit-classic-gcc/source/microbit-samples-combined.hex`
* C++ template for DAL v1: `vagrant_shared/cpp-template-dal-v1/build/bbc-microbit-classic-gcc/src/microbit-dalv1-template-combined.hex`

To load the application into the micro:bit you will need to copy the `microbit-xxx-combined.hex` file into the micro:bit USB drive.

### MicroPython
##### Project/code location
The MicroPython source code can be found in:

```bash
vagrant_shared/micropython/
```

##### Building
MicroPython has already been built, but if you wish to build it again, you can run in an SSH session:

```bash
cd ~/vagrant_shared/micropython/
yt clean
yt build
```

##### Built output locations
The MicroPython hex file is saved into the following path:

```bash
vagrant_shared/micropython/build/bbc-microbit-classic-gcc-nosd/source/microbit-micropython.hex
```

##### Flashing to the micro:bit
You can simply copy the MicroPython hex from the location above into your micro:bit USB drive.

To simplify the process and be able to load MicroPython with or without an additional Python program, [uflash](https://github.com/ntoll/uflash/) has been included with a wrapper script. So, from the host operating system:

```bash
python load_upy.py
``` 

or:

```bash
python load_upy.py <path to your python file>
```

For a quick test you could load any of the MicroPython examples for the microbit:

```bash
python load_upy.py vagrant_shared/micropython/examples/conway.py
```

##### Access the MicroPython REPL
Once MicroPython is flashed, you will have access to the REPL on the USB CDC serial port, with baudrate 115200 (eg `picocom /dev/ttyACM0 -b 115200` on Linux, `screen /dev/tty.usbmodem* 115200` on OS X, or a tool like putty on Windows).

If you have the Python package PySerial installed (`pip install pyserial`), you can also use [microrepl](https://github.com/ntoll/microrepl), which is already included:

```bash
python vagrant_shared/microrepl/microrepl.py
```

If you are running Windows you might need to install the microbit driver, which can be found at: https://developer.mbed.org/handbook/Windows-serial-configuration

### MakeCode

TODO


## License

[MIT](LICENSE)


## Trademarks
This projects is not endorsed, sponsored or associated with the BBC.
"BBC” and “micro:bit” are trade marks of the BBC. https://microbit.org
