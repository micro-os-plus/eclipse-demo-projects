# Eclipse demo projects with µOS++/CMSIS++ code

## Projects

### f4discovery-blinky-micro-os-plus

4 LEDS blinky project using the STM32F4DISCOVERY board (Cortex-M4, 1MB flash, 128KB RAM) and µOS++.

All code supplied by xPacks.

### f0discovery-blinky-micro-os-plus

2 LEDS blinky project using the STM32F0DISCOVERY board (Cortex-M0, 64KB flash, 8 KB RAM).

Code supplied by xPacks and CubeMX.

## How to use

To use any of these projects, you need to:

* clone the GitHub project locally
```
$ git clone https://github.com/micro-os-plus/eclipse-demo-projects.git eclipse-demo-projects.git
```
* in Eclipse, import the projects into your workspace, without copying
* build
* test the f4discovery-blinky-micro-os-plus on QEMU, it should blink the LEDs
* in a terminal window, start `scripts/update-xpacks-repo.sh` (on Mac you can double click the `update-xpacks-repo.command` in Finder); this will allow to later run the individual `generate.sh` scripts.
