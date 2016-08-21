# Main source folder

This is where the application source code is located.

The main application code is, no surprise, in `main.cpp`. As for most µOS++/CMSIS++ applications, this code includes the `os_main()` function, which already runs on a separate thread, with the scheduler fully functional.

The `led.cpp` includes a simple class to blink a led, using the HAL GPIO support.

Another specific µOS++/CMSIS++ file is `initialize_hardware.c`, which performs the necessary hardware initialisations, right before invoking the C++ static constructors.
