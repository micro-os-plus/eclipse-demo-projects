#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# -----------------------------------------------------------------------------
# Until the XCDL utility will be functional, use this Bash script
# to generate the project folders from the xPacks repository.
# -----------------------------------------------------------------------------

# Prefer the environment location XPACKS_FOLDER, if defined,
# but default to '.xpacks'.
xpacks_repo_folder="${XPACKS_REPO_FOLDER:-$HOME/.xpacks}"


# -----------------------------------------------------------------------------

if [[ ! -d "$xpacks_repo_folder" ]]
then
  mkdir -p ~/Downloads
  echo "Downloading bootstrap.sh..."
  curl -L https://github.com/xpacks/scripts/raw/master/bootstrap.sh -o ~/Downloads/bootstrap.sh
  bash  ~/Downloads/bootstrap.sh
fi

# -----------------------------------------------------------------------------

helper_script="$xpacks_repo_folder/ilg/scripts.git/xpacks-helper.sh"

# Include common definitions from helper script.
source "${helper_script}"

# -----------------------------------------------------------------------------

# Get the full absolute path of the current script.
script=$0
if [[ "${script}" != /* ]]
then
  # Make relative path absolute.
  script=$(pwd)/$0
fi

# -----------------------------------------------------------------------------

# Process command line options.
do_process_args $@

# Print greeting.
do_greet

# Recreate the destination folder.
do_remove_dest
do_create_dest

# Add the 'arm-cmsis' xPack.
do_add_arm_cmsis_xpack

# Add the 'micro-os-plus-iii' xPack.
do_add_micro_os_plus_iii_xpack

# Add the 'micro-os-plus-iii-cortexm' xPack.
do_add_micro_os_plus_iii_cortexm_xpack

# Add the 'stm32f4-cmsis' xPack.
do_add_stm32_cmsis_xpack "stm32f407xx"
# do_add_stm32_cmsis_drivers_xpack "f4"

# Add the 'stm32f4-hal' xpack.
do_add_stm32_hal_xpack "f4"

# Change file modes to read/only.
do_protect

# List result.
do_list

do_done
