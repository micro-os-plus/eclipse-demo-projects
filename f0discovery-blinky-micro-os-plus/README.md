# Blinky demo for STM32F0DISCOVERY, using µOS++

This demo program blinks the 2 coloured LEDs on the STM32F0DISCOVERY.

It demonstrates:

- how to organise a project using the content of several xPacks, including the **µOS++ IIIe / CMSIS++** code;
- how to integrate the CubeMX initialisation code;
- how to integrate CubeMX HAL & CMSIS code, including generating of the required `vectors_stm32*.c` file.

This project does not demonstrate any µOS++ features, the only RTOS feature used is the system clock `sleep_for()`, to delay execution for a number of ticks.

Until the XCDL utility will be available, the `generated` folder is created with the `scripts/generate.sh` script.
