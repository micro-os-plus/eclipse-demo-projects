# The CubeMX folder

This folder contains:

- the `Src` and `Inc` folders, with the initialisation code generated by CubeMX;
- the `Drivers` folder, with the HAL & CMSIS code;
- the `cube-mx.ioc` file, with the CubeMX configuration.

## How to further edit the hardware configuration?

The hardware configuration can be changed at any moment during development.

- start CubeMX
- load `cube-mx/cube-mx.ioc`
- edit
- generate the code again.

## Changes

The following changes were required to adapt the code generated by CubeMX to the µOS++ project.

### main.c

- add the header to include the trace functions
```
/* USER CODE BEGIN Includes */
#include "cmsis-plus/diag/trace.h"
/* USER CODE END Includes */
```
- rename `main()` to `cube_mx_init()`, by use of a preprocessor definition
```
/* USER CODE BEGIN 0 */
int
cube_mx_init(void);

#define main cube_mx_init
/* USER CODE END 0 */
```
- make `main()` return
```
  /* USER CODE BEGIN 3 */
  return 0;
  /* USER CODE END 3 */
```

### stm32f0xx_it.c

- add an external definition to µOS++ system time handler
```
/* USER CODE BEGIN 0 */
extern void os_systick_handler (void);
/* USER CODE END 0 */
```
- call the µOS++ system time handler in `the SysTick_Handler()`
```
  /* USER CODE BEGIN SysTick_IRQn 1 */
  os_systick_handler ();
  /* USER CODE END SysTick_IRQn 1 */
```

## HAL versions

The HAL version used by CubeMX, configured in `cube-mx.ioc` is:

```
ProjectManager.FirmwarePackage=STM32Cube FW_F0 V1.6.0
```

When starting, CubeMX will check the HAL version used by the project and offer to update if a newer HAL was installed.

After updating, the `generate.sh` should be executed, to recreate the packages based on the new HAL sources.

## stm32f0-cmsis-cube & stm32f0-hal-cube

This example does not benefit from the improved, warning free, xPacks with the STM code, so the files need to be copied from the sources provided by CubeMX.

For this, the CubeMX configuration must include the option to copy the sources locally:

```
ProjectManager.LibraryCopy=0
```

With this setting, the HAL & CMSIS code ends up in the large `Drivers` folder (more than 500 files).

However, for consistency reasons, the Eclipse project will not use the files in this folder, but will copy the required files in the generated `stm32f0-cmsis-cube` and `stm32f0-hal-cube` folders.

## vectors_stm32f051x8.c

One of the major drawbacks of the actual ARM CMSIS design is not only that it badly messes the startup code with the device vectors, but also requires to define this in nonportable asssembly code.

CMSIS++ corrected this, by separating the startup code from the vectors; the implementation is split into two files, one system specific `startup.c` and one device specific `vectors_DEVICE.c`.

With the vectors file not provided by the vendors, the creation script must do one more special trick and dynamically generate this file. The solution is to parse an existing assembly startup file and extract the list of handlers, then recreate the .c file. The code to do this magic is available in the `generate-helper.sh` script (just don't ask what those many regular expressions do!).
