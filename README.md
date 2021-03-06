# Eclipse demo projects with µOS++/CMSIS++ code

## Projects

### f4discovery-blinky-micro-os-plus

4 LEDS blinky project using the STM32F4DISCOVERY board (Cortex-M4, 1MB flash, 128KB RAM) and µOS++.

All dependencies supplied by xPacks.

### f746gdiscovery-blinky-micro-os-plus

1 LED blinky project using the 32F746GDISCOVERY board (Cortex-M7, 1MB flash, 340KB RAM) and µOS++.

All dependencies supplied by xPacks.

### f0discovery-blinky-micro-os-plus

2 LEDS blinky project using the STM32F0DISCOVERY board (Cortex-M0, 64KB flash, 8 KB RAM).

Dependencies supplied by xPacks and CubeMX.

## Prerequisites

These projects have several dependencies to code available from xPacks. To satisfy these dependencies it is necessary to run the `generate.sh` shell scripts.

### macOS

All scripts were created on macOS, and the ones suffixed with `.command` are specific to macOS.

As usual for development machines, the _Apple Xcode Command Line Tools_ must be installed.

### GNU/Linux

The scripts were also tested on several GNU/Linux distributions, and should be fine.

On Ubuntu be sure you have `git` and `curl` available:

```
suso apt-get git curl
```

For other distributions, similar commands must be issued.

### Windows

The scripts were also tested on Windows **MSYS2**, **Git Shell**, and on the new [Windows Subsystem for Linux](https://msdn.microsoft.com/commandline/wsl/about).

The only difference is the lack of symbolic links, so `--symlink` should not be used and instead `--link` is fully functional, but the `generate.sh` script should be executed after updating the git repositories in `/.xpacks`.

For those who insist on native Windows, separate PowerShell scripts would be required, but considering Microsoft's move towards Linux, this would probably not be worth the effort. Anyway, if you manage to create them, please consider improving your karma and contribute them back to the community.

## How to use

To use any of these projects, you need to:

* clone the GitHub project locally
```
$ git clone https://github.com/micro-os-plus/eclipse-demo-projects.git eclipse-demo-projects.git
```
* in each project, generate the code required to satisfy the dependencies; on macOS, double click the `scripts/generate.mac.command` in Finder; on other platforms, go to the project folder and run the `generate.sh` script
```
$ bash scripts/generate.sh
```
* in Eclipse, import the projects into your workspace, **without copying**
* build
* test the f4discovery-blinky-micro-os-plus on QEMU, it should blink the LEDs

For more details, please refer to the project specific README files:

* [f0discovery-blinky-micro-os-plus/README](f0discovery-blinky-micro-os-plus/README.md)
* [f4discovery-blinky-micro-os-plus/README](f4discovery-blinky-micro-os-plus/README.md)
* [f746gdiscovery-blinky-micro-os-plus/README](f746gdiscovery-blinky-micro-os-plus/README.md)

## Keep xPacks up-to-date

To update the content of the xPacks to the latest versions, in a terminal window, start the `xpacks-update-repo.sh` Bash script:

```
$ bash ~/.xpacks/ilg/scripts.git/xpacks-update-repo.sh
```

On Mac you can double click the `xpacks-update-repo.mac.command` in Finder.

After updating xPacks, run the `generate.sh` script in each project, to update the project dependencies.




