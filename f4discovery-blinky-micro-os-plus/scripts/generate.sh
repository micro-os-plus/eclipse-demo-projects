#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Get the full absolute path of the current script.
script=$0
if [[ "${script}" != /* ]]
then
  # Make relative path absolute.
  script=$(pwd)/$0
fi

# Helper script is in parent folder scripts.
helper_script="$(dirname $(dirname $(dirname ${script})))/scripts/generate-helper.sh"

# Include common definitions from helper script.
source "${helper_script}"

# Process command line options.
do_process_args $@

# Print greeting.
do_greet

# Recreate the destination folder.
do_remove_dest
do_create_dest

# Add the 'arm-cmsis' xPack.
do_add_arm_cmsis_xpack

# Add the 'cmsis-plus' xPack.
do_add_cmsis_plus_xpack

# Add the 'micro-os-plus-iii' xPack.
do_add_micro_os_plus_iii_xpack

# Add the 'stm32f4-cmsis' xPack.
do_add_stm32_cmsis_xpack "stm32f407xx"

# Add the 'stm32f4-hal' xpack.
do_add_stm32_hal_xpack "f4"

# Change file modes to read/only.
do_protect

# List result.
do_list

do_done
