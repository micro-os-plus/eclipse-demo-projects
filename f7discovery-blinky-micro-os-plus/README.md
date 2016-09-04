# Blinky demo for STM32F7DISCOVERY, using µOS++

This demo program blinks the LED on the STM32F7DISCOVERY (the blink code
is copied from F4DISCOVERY, which has 4 LEDs, for this board it is a bit of
a overkill).

It demonstrates:

- how to organise a project using the content of several xPacks, including the **µOS++ IIIe / CMSIS++** code;
- how to integrate the CubeMX initialisation code.

This project **does not** demonstrate any µOS++ features, the only RTOS feature used is the system clock `sleep_for()`, to delay execution for a number of ticks.

Until the XCDL utility will be available, the `generated` folder is created with the `scripts/generate.sh` script.
