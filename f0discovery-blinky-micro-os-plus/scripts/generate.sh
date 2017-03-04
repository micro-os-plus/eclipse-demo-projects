#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# -----------------------------------------------------------------------------
# Until the xPacks utilities will be functional, use this Bash script
# to generate the project folders from the xPacks repository.
# -----------------------------------------------------------------------------

# Prefer the environment location XPACKS_REPO_FOLDER, if defined.

xpacks_paths_helper_path="${HOME}/Downloads/xpacks-paths.sh"

# Check if the helper is present.
if [ ! -f "${xpacks_paths_helper_path}" ]
then
  mkdir -p "${HOME}/Downloads"
  echo "Downloading xpacks-paths.sh..."
  curl -L https://github.com/xpacks/scripts/raw/master/xpacks-paths.sh -o "${xpacks_paths_helper_path}"
fi

source  "${xpacks_paths_helper_path}"

# -----------------------------------------------------------------------------

# Process command line options.
do_process_args $@

# Print greeting.
do_greet

# Check dependencies; clone if not found.
do_install_xpack "arm-cmsis" "ilg" "https://github.com/xpacks/arm-cmsis.git"
do_install_xpack "micro-os-plus-iii" "ilg" "https://github.com/micro-os-plus/micro-os-plus-iii.git"
do_install_xpack "micro-os-plus-iii-cortexm" "ilg" "https://github.com/micro-os-plus/micro-os-plus-iii-cortexm.git"
do_install_xpack "stm" "ilg" "https://github.com/xpacks/stm.git"

# Recreate the destination folder.
do_remove_dest
do_create_dest

# Add the 'arm-cmsis' xPack.
do_add_arm_cmsis_xpack

# Add the 'micro-os-plus-iii' xPack.
do_add_micro_os_plus_iii_xpack

# Add the 'micro-os-plus-iii-cortexm' xPack.
do_add_micro_os_plus_iii_cortexm_xpack

# Add the STM32F0xx CMSIS code from CubeMX.
do_add_stm32_cmsis_cube "stm32f051x8"

# Add the STM32F0xx_HAL_Driver code from CubeMX.
do_add_stm32_hal_cube "f0"

# Change file modes to read/only.
do_protect

# List result.
do_list

do_done
