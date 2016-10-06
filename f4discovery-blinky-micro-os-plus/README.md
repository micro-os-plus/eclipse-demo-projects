# Blinky demo for STM32F4DISCOVERY, using µOS++

This demo program blinks the 4 coloured LEDs on the STM32F4DISCOVERY.

It demonstrates:

- how to organise a project using the content of several xPacks, including the **µOS++ IIIe / CMSIS++** code;
- how to integrate the CubeMX initialisation code.

This project **does not** demonstrate any µOS++ features, the only RTOS feature used is the system clock `sleep_for()`, to delay execution for a number of ticks.

## Preliminary

The content of the xPacks is not part of the repository, and must be dynamically generated. Until the XCDL utility will be available, the `generated` folder should be created with the `scripts/generate.sh` script.

```
bash scripts/generate.sh
```

## Build details

### Include folders

- `include`
- `cube-mx/Inc`
- `generated/arm-cmsis/include/core`
- `generated/micro-os-plus-iii/include`
- `generated/micro-os-plus-iii-cortexm/include`
- `generated/stm32f4-cmsis/include/stm32f407xx`
- `generated/stm32f4-hal/include`

### Source folders

- `src`
- `cube-mx/Src`
- `generated/micro-os-plus-iii/src`
- `generated/micro-os-plus-iii-cortexm/src`
- `generated/stm32f4-cmsis/src/stm32f407xx`
- `generated/stm32f4-hal/src`

### Compile options

The µOS++ code uses modern C++ features, and for this it is necessary to use a recent GCC version (v5.x or highrer) and to specify `-std=gnu++1y` in the GCC command line.

### Additional settings

- for `generated/stm32f4-hal/src`, to silence C warnings, use `-Wno-sign-conversion -Wno-padded -Wno-conversion -Wno-unused-parameter -Wno-bad-function-cast -Wno-sign-compare`


## Semihosting

To simplify testing, this demo uses the ARM semihosting API to access the host; this is enabled via `OS_USE_SEMIHOSTING_SYSCALLS` defined on the compiler command line. To run, semihosting normally requires an active debugger connection with the debugged board. However, the µOS++ exception handlers are enhanced with code to fake the semihosting calls if the debugger connection is not active (the JTAG/SWD cable is not connected). Unfortunately these features are available only for ARMv7M devices, so, for small Cortex-M0/M0+ devices, the debugger connection is manadatory.

For standalone applications, remove `OS_USE_SEMIHOSTING_SYSCALLS` and possibly add `-ffreestanding` to the compiler command line.
