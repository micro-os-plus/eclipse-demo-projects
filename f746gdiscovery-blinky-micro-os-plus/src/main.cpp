/*
 * This file is part of the µOS++ distribution.
 *   (https://github.com/micro-os-plus)
 * Copyright (c) 2016 Liviu Ionescu.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom
 * the Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

// ----------------------------------------------------------------------------

#include <cmsis-plus/rtos/os.h>

#include <led.h>

using namespace os::rtos;

// ----------------------------------------------------------------------------
//
// Semihosting STM32F7 led blink sample (trace via DEBUG).
//
// In debug configurations, demonstrate how to print a greeting message
// on the trace device. In release configurations the message is
// simply discarded.
//
// To demonstrate semihosting, display a message on the standard output
// and another message on the standard error.
//
// Then demonstrates how to blink a led with 1 Hz, using a
// continuous loop and SysTick delays.
//
// On DEBUG, the uptime in seconds is also displayed on the trace device.
//
// Trace support is enabled by adding the TRACE macro definition.
// By default the trace messages are forwarded to the DEBUG output,
// but can be rerouted to any device or completely suppressed, by
// changing the definitions required in system/src/diag/trace_impl.c
// (currently OS_USE_TRACE_ITM, OS_USE_TRACE_SEMIHOSTING_DEBUG/_STDOUT).
//

// Definitions visible only within this translation unit.
namespace
{
  // ----- Timing definitions -------------------------------------------------

  // Keep the LED on for 2/3 of a second.
  constexpr clock::duration_t BLINK_ON_TICKS = sysclock.frequency_hz * 3 / 4;
  constexpr clock::duration_t BLINK_OFF_TICKS = sysclock.frequency_hz
      - BLINK_ON_TICKS;
}

// ----- LED definitions ------------------------------------------------------

// The 32F746GDISCOVERY has a single LED, PI1, active high.
#define BLINK_PORT_NUMBER         (8)
#define BLINK_PIN_NUMBER          (1)
#define BLINK_ACTIVE_LOW          (false)

led blink_leds[1] =
  {
    { BLINK_PORT_NUMBER, BLINK_PIN_NUMBER, BLINK_ACTIVE_LOW },
  };

// ----- main() ---------------------------------------------------------------

// Sample pragmas to cope with warnings. Please note the related line at
// the end of this function, used to pop the compiler diagnostics status.
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wmissing-declarations"
#pragma GCC diagnostic ignored "-Wreturn-type"

int
os_main(int argc, char* argv[])
{
  // Send a greeting to the trace device (skipped on Release).
  trace_puts("Hello ARM World!");

  // Send a message to the standard output.
  puts("Standard output message.");

  // Send a message to the standard error.
  fprintf(stderr, "Standard error message.\n");

  // At this stage the system clock should have already been configured
  // at high speed.
  trace_printf("System clock: %u Hz\n", SystemCoreClock);

  // Perform all necessary initialisations for the LEDs.
  for (size_t i = 0; i < (sizeof(blink_leds) / sizeof(blink_leds[0])); ++i)
    {
      blink_leds[i].power_up ();
    }

  uint32_t seconds = 0;

#define LOOP_COUNT (1 << (sizeof(blink_leds) / sizeof(blink_leds[0])))

  int loops = LOOP_COUNT > 2 ? LOOP_COUNT : (5);
  if (argc > 1)
    {
      // If defined, get the number of loops from the command line,
      // configurable via semihosting.
      loops = atoi (argv[1]);
      if (loops < LOOP_COUNT)
        {
          loops = LOOP_COUNT;
        }
    }

  for (size_t i = 0; i < (sizeof(blink_leds) / sizeof(blink_leds[0])); ++i)
    {
      blink_leds[i].turn_on ();
    }

  // First second is long.
  sysclock.sleep_for(sysclock.frequency_hz);

  for (size_t i = 0; i < (sizeof(blink_leds) / sizeof(blink_leds[0])); ++i)
    {
      blink_leds[i].turn_off ();
    }

  sysclock.sleep_for (BLINK_OFF_TICKS);

  ++seconds;
  trace_printf ("Second %u\n", seconds);

  if ((sizeof(blink_leds) / sizeof(blink_leds[0])) > 1)
    {
      // Blink individual LEDs.
      for (size_t i = 0; i < (sizeof(blink_leds) / sizeof(blink_leds[0])); ++i)
        {
          blink_leds[i].turn_on ();
          sysclock.sleep_for(BLINK_ON_TICKS);

          blink_leds[i].turn_off ();
          sysclock.sleep_for (BLINK_OFF_TICKS);

          ++seconds;
          trace_printf ("Second %u\n", seconds);
        }

      // Blink binary.
      for (int i = 0; i < loops; i++)
        {
          for (size_t l = 0; l < (sizeof(blink_leds) / sizeof(blink_leds[0]));
              ++l)
            {
              blink_leds[l].toggle ();
              if (blink_leds[l].is_on ())
                {
                  break;
                }
            }
          sysclock.sleep_for (sysclock.frequency_hz);

          ++seconds;
          trace_printf ("Second %u\n", seconds);
        }
    }
  else
    {
      for (int i = 0; i < loops; i++)
        {
          blink_leds[0].turn_on ();
          sysclock.sleep_for (BLINK_ON_TICKS);

          blink_leds[0].turn_off ();
          sysclock.sleep_for (BLINK_OFF_TICKS);

          ++seconds;
          trace_printf ("Second %u\n", seconds);
        }
    }

  for (size_t i = 0; i < (sizeof(blink_leds) / sizeof(blink_leds[0])); ++i)
    {
      blink_leds[i].turn_on ();
    }

  sysclock.sleep_for (sysclock.frequency_hz);

  return 0;
}

#pragma GCC diagnostic pop

// ----------------------------------------------------------------------------
