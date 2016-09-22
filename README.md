# Eclipse demo projects with µOS++/CMSIS++ code

## Projects

### f4discovery-blinky-micro-os-plus

4 LEDS blinky project using the STM32F4DISCOVERY board (Cortex-M4, 1MB flash, 128KB RAM) and µOS++.

All code supplied by xPacks.

### f746gdiscovery-blinky-micro-os-plus

1 LED blinky project using the 32F746GDISCOVERY board (Cortex-M7, 1MB flash, 340KB RAM) and µOS++.

All code supplied by xPacks.

### f0discovery-blinky-micro-os-plus

2 LEDS blinky project using the STM32F0DISCOVERY board (Cortex-M0, 64KB flash, 8 KB RAM).

Code supplied by xPacks and CubeMX.

## Prerequisites

These projects have several dependencies to code available from xPacks. To satisfy these dependencies it is necessary to run some shell scripts.

These scripts were created on macOS, and the ones suffixed with `.command` are specific to macOS; the `.sh` scripts should also be fine on GNU/Linux, Windows MSYS2, Git Shell, and on the new [Windows Subsystem for Linux](https://msdn.microsoft.com/commandline/wsl/about).

For those who insist on native Windows, separate PowerShell scripts would be required, but considering Microsoft's move towards Linux, this would probably not be worth the effort. Anyway, if you manage to create them, please consider improving your karma and contribute them back to the community.

## How to use

To use any of these projects, you need to:

* clone the GitHub project locally
```
$ git clone https://github.com/micro-os-plus/eclipse-demo-projects.git eclipse-demo-projects.git
```
* in each project, generate the code required to satisfy the dependencies; on macOS, double click the `scripts/generate.mac.command` in Finder; on other platforms, go to the project folder and run 
```
$ bash scripts/generate.sh
```
* in Eclipse, import the projects into your workspace, **without copying**
* build
* test the f4discovery-blinky-micro-os-plus on QEMU, it should blink the LEDs

## Keep xPacks up-to-date

To update the content of the xPacks, in a terminal window, start the `update-xpacks-repo.sh` Bash script:

```
$ bash ~/.xpacks/ilg/scripts.git/update-xpacks-repo.sh
```

On Mac you can double click the `update-xpacks-repo.command` in Finder.

After updating xPacks, run the `generate.sh` script in each project, to update the project dependencies.




