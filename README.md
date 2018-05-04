# BBC micro:bit Development Environment for C/C++, MakeCode, and MicroPython

This repository contains a Vagrant box configured to facilitate the development of MicroPython, MakeCode, and C/C++ programs for the BBC micro:bit.

It uses [Vagrant](https://www.vagrantup.com/intro/index.html), a tool to easily build and manage virtual machine environments.

This virtual machine is very easy to use and contains everything you need to:

* Build micro:bit MicroPython from source
	* Easily load Python scripts using your own built MicroPython
	* Easily access the MicroPython REPL
* Run a local version of MakeCode/PXT
* Develop your own MakeCode packages
* Build C/C++ applications for the micro:bit

With a single command this project takes care of creating a virtual machine, installing all the development tools and dependencies required, download all the source code, compile everything, and get it ready for use.

It offers a replicable development environment that is independent of your operating system, working the same way under Windows, macOS, or Linux.


## Table of contents:

* [Install](#install)
* [Access the virtual machine](#access-the-virtual-machine)
* [Workflow](#workflow)
* [Environments](#environments)
	* [C/C++](#cc)
	* [MicroPython](#micropython)
	* [MakeCode](#makecode)
* [License](#license)
* [Trademarks](#trademarks)


## Install

### Prerequisites
You will need the following applications first:

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* (Optional) [Python](https://www.python.org/)

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

First, start-up the virtual machine:
```bash
vagrant up
```

You can now SSH into the virtual machine with Vagrant itself:

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

To stop the virtual machine from running, you can use the following command on the host:

```
vagrant halt
```

More information can be found in the [Vagrant documentation](https://www.vagrantup.com/docs/).


## Workflow

The general workflow concept is to have one folder that is accessible by both the host operating system (your computer), and the virtual machine.

This allows you to create and edit your code like you would normally do, using any IDE or editor you prefer, and then use the virtual machine to build it or compile it.

In essence the steps are:

* Edit the code inside the `vagrant_shared` folder in your OS as you would normally do
* SSH into the virtual machine
* Compile/build the project from the SSH session (accessible via `~/vagrant_shared/`)
* The built output can be accessed from the `vagrant_shared` folder within your OS

The `vagrant_shared` folder is where the source code and projects have to be located, as Vagrant configures it as a shared folder that can be accessed indiscriminately by both your OS and the virtual machine.
Remember! If you delete something within the virtual machine `~/vagrant_shared/` directory it will also be removed from the folder you see in your Operating System.

The `vagrant_shared` directory has been gitignored, so feel free to add or clone your own repositories there without interference from this one.


## Environments

### C/C++
#### Project/code location
There are two C/C++ projects:
* [microbit samples](https://github.com/lancaster-university/microbit-samples): A collection of example programs using the micro:bit runtime (DAL).
	```
	vagrant_shared/cpp-samples/
	```
* [C++ template for DAL v1](https://github.com/carlosperate/microbit-dal-v1-cpp-template): Simple hello world program template using an older version of the micro:bit runtime/DAL (v1.4.x). This is the same DAL version used by MicroPython v0.9, so it's only useful for cases where you might need to test something for MicroPython development.
	```
	vagrant_shared/cpp-template-dal-v1/
	```

#### Building
Both C/C++ projects have already been built, but if you wish to recompile the examples you can access the virtual machine via SSH, and within the project directory run:

```bash
yt clean
yt build
```

The `cpp-samples/source/examples` folder contains a selection of samples demonstrating the capabilities and usage of the runtime APIs. To select a sample, simply copy the .cpp files from the relevant folder into the `cpp-samples/source/` folder. More info can be found in the [microbit samples](https://github.com/lancaster-university/microbit-samples) repository.

#### Built output locations
* microbit samples:
    ```
    vagrant_shared/cpp-samples/build/bbc-microbit-classic-gcc/source/microbit-samples-combined.hex
    ```
* C++ template for DAL v1:
    ```
    vagrant_shared/cpp-template-dal-v1/build/bbc-microbit-classic-gcc/src/microbit-dalv1-template-combined.hex
    ```

To load the application into the micro:bit you will need to copy the `microbit-xxx-combined.hex` file into the micro:bit USB drive.

### MicroPython
#### Project/code location
The MicroPython source code can be found in:

```bash
vagrant_shared/micropython/
```

#### Building
MicroPython has already been built, but if you wish to build it again, you can open an SSH session and run:

```bash
cd ~/vagrant_shared/micropython/
yt clean
yt build
```

#### Built output locations
The MicroPython hex file is saved into the following path:

```bash
vagrant_shared/micropython/build/bbc-microbit-classic-gcc-nosd/source/microbit-micropython.hex
```

#### Flashing to the micro:bit
You can simply copy the MicroPython hex into your micro:bit USB drive.

To simplify the process and be able to load MicroPython with or without an additional Python program, [uflash](https://github.com/ntoll/uflash/) has been included with a wrapper script. So, from the host operating system you can run the following if you have Python (2 or 3) installed.

To load only the new MicroPython simply run this script:

```bash
python upy_load.py
``` 

To load the new MicroPython together with your Python code:

```bash
python upy_load.py <path to your python file>
```

For a quick test you could load any of the included MicroPython examples for the microbit:

```bash
python upy_load.py vagrant_shared/micropython/examples/conway.py
```

All command line arguments sent to the `upy_load.py` wrapper script are sent over to uFlash (more info about available options in the [uFlash's README](https://github.com/ntoll/uflash)). So, for example, if you'd like to save the combined `micropython.hex` file (MicroPython + user Python code) into the current directory (indicated using `.`), you can do so with the following command:

```bash
python upy_load.py vagrant_shared/micropython/examples/conway.py .
```

#### Access the MicroPython REPL
Once MicroPython is flashed, you will have access to the REPL on the USB CDC serial port, with baud rate 115200 (eg `picocom /dev/ttyACM0 -b 115200` on Linux, `screen /dev/tty.usbmodem* 115200` on OS X, or a tool like putty/TeraTerm on Windows).

The [microrepl](https://github.com/ntoll/microrepl) tool is also bundled and easily accessible via a provided helper script. If you'd like to access the micro:bit REPL using your host computer terminal/console you can simply run the following Python (2 or 3) script:

```bash
python upy_repl.py
```

If you are running Windows you might need to install the microbit driver, which can be found at: https://developer.mbed.org/handbook/Windows-serial-configuration

### MakeCode

TODO


## License

[MIT](LICENSE)


## Trademarks

This projects is not endorsed, sponsored or associated with the BBC.
"BBC” and “micro:bit” are trade marks of the BBC. https://microbit.org
