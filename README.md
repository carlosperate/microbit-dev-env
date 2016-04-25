# BBC micro:bit C/C++ and MicroPython Development Environment
This repository contains a Vagrant script to facilitate the development of MicroPython and other C/C++ applications for the BBC micro:bit.

This takes care of creating a virtual machine, installing all the development tools required, and get everything ready to compile. This useful tool offers a replicable development environment independent of your operating system, working the same way under Windows, OS X, or Linux.


## Prerequisites
You will need to have the following first:

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* An [mbed account](https://www.mbed.com/) (you will need to login during installation!)


## Installing
Clone, or [download](https://github.com/carlosperate/microbit-micropython-dev-env.git) this repository:

```bash
git clone https://github.com/carlosperate/microbit-dev-env.git
cd microbit-dev-env
```

Getting the virtual machine up and running with Vagrant is extremely easy, on the Command Line Interface at the project folder run:

```bash
vagrant up
```

This will download an Ubuntu 14.04 32 bit virtual box image, so it might take a while depending on your internet connection. It will also install the toolchain, and download and compile the MicroPython source code and C++ examples, ensuring everything is ready to develop your applications.

Please note! During one of the last stages of the installation, the **command line interface will request you to login to your mbed account**.
A link should be printed on the console with a clear message, login to that page from your browser. The command line should automatically detect it and continue with the installation.


## Access the virtual machine
Once you have the Vagrant box up and running (ensure it is with the `vagrant up` command), you can SSH with Vagrant:

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

This will give you command line access to the virtual machine, allowing you to compile the source code contained in this project folder. By default you will find the `cpp-samples`, `micropython` and a couple of extra folders there, which can be accessed from the virtual machine to build the projects. So on the SSH connection:

```bash
ls
cd vagrant_shared/micropython
yt build
cd ../cpp-samples
yt build
```

To close the virtual machine from running on the background, you can use the following command on the host:

```
vagrant halt
```

More information can be found in the [Vagrant documentation](https://www.vagrantup.com/docs/).


## Load the C++ examples to the micro:bit
The C++ examples are built to the following file, by default the "hello world" example is compiled:

```
vagrant_shared/cpp-samples/build/bbc-microbit-classic-gcc/source/microbit-samples-combined.hex
```

To load the application into the microbit you will need to copy the `microbit-samples-combined.hex` file into the microbit USB drive.

To compile a different example, edit the `MicroBitSamples.h` file in the `vagrant_shared/cpp-samples/source` folder and uncomment the line matching the sample you wish to use (only a single example should be uncommented). 

To recompile the examples access the virtual machine via SSH and execute:

```bash
cd vagrant_shared/cpp-samples
yt build
```


## Load MicroPython to the micro:bit
The MicroPython hex file is saved into the following path, which you can drop into the microbit USB drive for flashing:

```bash
vagrant_shared/micropython/build/bbc-microbit-classic-gcc-nosd/source/microbit-micropython.hex
```

To simplify the process [uflash](https://github.com/ntoll/uflash/) has been included with a wrapper script to load MicroPython with or without an additional Python program. So, from the host operating system:

```bash
python load_upy.py
``` 

or

```bash
python load_upy.py <path to your python file>
```

For a quick test you could load any of the MicroPython examples for the microbit:

```bash
python load_upy.py vagrant_shared/micropython/examples/conway.py
```


### Access the MicroPython REPL
Once MicroPython is flashed, you will have access to the REPL on the USB CDC serial port, with baudrate 115200 (eg `picocom /dev/ttyACM0 -b 115200` on Linux, `screen /dev/tty.usbmodem* 115200` on OS X, or a tool like putty on Windows).

If you have the Python package PySerial installed (`pip install pyserial`), you can also use [microrepl](https://github.com/ntoll/microrepl), which is already included:

```bash
python vagrant_shared/microrepl/microrepl.py
```

If you are running Windows you might need to install the microbit driver, which can be found at: https://developer.mbed.org/handbook/Windows-serial-configuration


## Workflow
The general workflow concept for this Vagrant configuration is to be able do the compilation on the virtual machine, while being able to access and work on the source code with your preferred tools on your host operating system.

So, at the top level of the project directory you will find the `vagrant_shared` folder, a shared folder between host and guest vm. The host location for this folder is `~/vagrant_shared` and this is where the MicroPython source code, C++ examples, the microrepl, and uflash have been downloaded as git repository clones.

The `vagrant_shared` directory has been gitignored, so feel free to add your own repositories there without interference from this one. 


## Trademarks
This projects is not endorsed, sponsored or associated with the BBC.
"BBC” and “micro:bit” are trade marks of the BBC. http://microbit.co.uk/
