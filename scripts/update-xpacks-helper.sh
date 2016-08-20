#!/bin/bash
#set -euo pipefail
#IFS=$'\n\t'

xpacks_repo_folder="$HOME/.xpacks"

do_process_args() {
  use_development_tree=""

  while [ $# -gt 0 ]
  do
    case "$1" in

      --dev-tree)
        use_development_tree="$2"
        shift 2
        ;;

      --help)
        echo "Update xpacks."
        echo "Usage:"
        echo "    bash $(basename $0) [--dev-tree absolute-path] [--help]"
        echo
        exit 1
        ;;

      *)
        echo "Unknown option $1"
        exit 1
        ;;
    esac
  done
}

do_greet() {
  project_name="$(basename $(dirname $(dirname ${script})))"
  echo "* Generating xpacks for '${project_name}' *"
  echo
}

do_remove_dest() {
  xpack_dest_folder="$(dirname $(dirname ${script}))/xpacks"

  if [ -d "${xpack_dest_folder}" ]
  then
    echo "Removing '${xpack_dest_folder}'..."

    chmod -R +w "${xpack_dest_folder}"
    rm -rf "${xpack_dest_folder}"
  fi
}

do_create_dest() {
  mkdir -p "${xpack_dest_folder}"
  echo "This folder was automatically generated." >"${xpack_dest_folder}/GENERATED_NOT_EDITABLE.txt"
  echo "All files are set read-only and cannot be edited." >>"${xpack_dest_folder}/GENERATED_NOT_EDITABLE.txt"
}

do_protect() {
  echo
  echo "Changing mode to R/O..."
  chmod -R -w "${xpack_dest_folder}"
}

do_list() {
  echo
  ls -l "${xpack_dest_folder}"
}

do_done() {

  echo
  echo "Done."
}

# $1 = xpack name
# $2 = git path
# $3 = tree path
do_prepare_xpack() {
  echo
  echo "Processing '$1'..."

  if [ -n "${use_development_tree}" ]
  then
    pack_folder="${use_development_tree}/$3"
  else
    pack_folder="${xpacks_repo_folder}/$2"
  fi
  dest_folder="${xpack_dest_folder}/$1"
}

do_create_include() {
  echo "Creating '${dest_folder}/include'..."
  mkdir -p "${dest_folder}/include"
}

do_create_src() {
  echo "Creating '${dest_folder}/src'..."
  mkdir -p "${dest_folder}/src"
}

# -----------------------------------------------------------------------------

do_add_arm_cmsis() {
  do_prepare_xpack "arm-cmsis" "ilg/arm-cmsis.git" "ilg/arm/arm-cmsis-xpack"

  do_create_include
  cp -r "${pack_folder}/CMSIS/Include"/* "${dest_folder}/include"
}

# -----------------------------------------------------------------------------

do_add_cmsis_plus() {
  do_prepare_xpack "micro-os-plus" "ilg/cmsis-plus.git" "ilg/arm/cmsis-plus-xpack"

  do_create_include

  cp -r "${pack_folder}/include"/* "${dest_folder}/include"

  do_create_src

  cp -r "${pack_folder}/src/diag" "${dest_folder}/src"
  cp -r "${pack_folder}/src/libc" "${dest_folder}/src"
  cp -r "${pack_folder}/src/libcpp" "${dest_folder}/src"
  cp -r "${pack_folder}/src/rtos" "${dest_folder}/src"
  cp -r "${pack_folder}/src/semihosting" "${dest_folder}/src"
  cp -r "${pack_folder}/src/startup" "${dest_folder}/src"
}

# -----------------------------------------------------------------------------

do_add_micro_os_plus_iii() {
  do_prepare_xpack "micro-os-plus" "ilg/micro-os-plus-iii.git" "ilg/portable/micro-os-plus-xpack"

  mkdir -p "${dest_folder}/include"

  cp -r "${pack_folder}/include"/* "${dest_folder}/include"

  mkdir -p "${dest_folder}/src/rtos/port"

  cp -r "${pack_folder}/src/rtos"/* "${dest_folder}/src/rtos/port"
}

# -----------------------------------------------------------------------------

# $1 = device name suffix (like "stm32f407xx")
do_add_stm32f4_cmsis() {
  do_prepare_xpack "stm32f4-cmsis" "ilg/stm32f4-cmsis.git" "ilg/stm/stm32f4-cmsis-xpack"

  do_create_include

  cp -r "${pack_folder}/Drivers/CMSIS/Device/ST/STM32F4xx/Include/cmsis_device.h" "${dest_folder}/include"
  cp -r "${pack_folder}/Drivers/CMSIS/Device/ST/STM32F4xx/Include/stm32f4xx.h" "${dest_folder}/include"
  cp -r "${pack_folder}/Drivers/CMSIS/Device/ST/STM32F4xx/Include/${1}.h" "${dest_folder}/include"
  cp -r "${pack_folder}/Drivers/CMSIS/Device/ST/STM32F4xx/Include/system_stm32f4xx.h" "${dest_folder}/include"

  do_create_src

  cp -r "${pack_folder}/Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c" "${dest_folder}/src"
  cp -r "${pack_folder}/Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/vectors_${1}.c" "${dest_folder}/src"
}

# -----------------------------------------------------------------------------

do_add_stm32f4_hal() {
  do_prepare_xpack "stm32f4-hal" "ilg/stm32f4-hal.git" "ilg/stm/stm32f4-hal-xpack"

  do_create_include

  cp -r "${pack_folder}/Drivers/STM32F4xx_HAL_Driver/Inc"/* "${dest_folder}/include"

  do_create_src

  cp -r "${pack_folder}/Drivers/STM32F4xx_HAL_Driver/Src"/* "${dest_folder}/src"
}

# -----------------------------------------------------------------------------
