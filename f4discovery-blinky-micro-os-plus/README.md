# Blinky demo for STM32F4DISCOVERY, using µOS++

This demo program blinks the 4 coloured LEDs on the STM32F4DISCOVERY.

It demonstrates:

- how to organise a project using the content of several xPacks, including the **µOS++ IIIe / CMSIS++** code;
- how to integrate the CubeMX initialisation code.

This project **does not** demonstrate any µOS++ features, the only RTOS feature used is the system clock `sleep_for()`, to delay execution for a number of ticks.

Until the XCDL utility will be available, the `generated` folder is created with the `scripts/generate.sh` script.

## Build options

The µOS++ code uses modern C++ features, and for this it is necessary to use a recent GCC version (v5.x or highrer) and to specify `-std=gnu++1y` in the GCC command line.

## Semihosting

To simplify testing, this demo uses the ARM semihosting API to access the host; this is enabled via `OS_USE_SEMIHOSTING_SYSCALLS` defined on the compiler command line. To run, semihosting normally requires an active debugger connection with the debugged board. However, the µOS++ exception handlers are enhanced with code to fake the semihosting calls if the debugger connection is not active (the JTAG/SWD cable is not connected). Unfortunately these features are available only for ARMv7M devices, so, for small Cortex-M0/M0+ devices, the debugger connection is manadatory.

For standalone applications, remove `OS_USE_SEMIHOSTING_SYSCALLS` and possibly add `-ffreestanding` to the compiler command line.
