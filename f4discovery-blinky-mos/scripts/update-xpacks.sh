#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

xpacks_repo_folder="$HOME/.xpacks"

use_development_tree=""

script=$0
if [[ "${script}" != /* ]]
then
  # Make relative path absolute.
  script=$(pwd)/$0
fi

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
      echo "    bash $0 [--dev-tree absolute-path] [--help]"
      echo
      exit 1
      ;;

    *)
      echo "Unknown option $1"
      exit 1
      ;;
  esac
done

project_name="$(basename $(dirname $(dirname ${script})))"
echo "* Generating xpacks for '${project_name}' *"
echo

xpack_dest_folder="$(dirname $(dirname ${script}))/xpacks"

if [ -d "${xpack_dest_folder}" ]
then
  echo "Removing '${xpack_dest_folder}'..."

  chmod -R +w "${xpack_dest_folder}"
  rm -rf "${xpack_dest_folder}"
fi

mkdir -p "${xpack_dest_folder}"
echo "This folder was automatically generated." >"${xpack_dest_folder}/GENERATED_DO_NOT_EDIT.txt"
echo "All files are set read-only and cannot be edited." >>"${xpack_dest_folder}/GENERATED_DO_NOT_EDIT.txt"

# arm-cmsis

echo
echo "Processing 'arm-cmsis'..."

if [ -n "${use_development_tree}" ]
then
  pack_folder="${use_development_tree}/ilg/arm/arm-cmsis-xpack"
else
  pack_folder="${xpacks_repo_folder}/ilg/arm-cmsis.git"
  exit
fi
dest_folder="${xpack_dest_folder}/arm-cmsis"

echo "Creating '${dest_folder}/include'..."
mkdir -p "${dest_folder}/include"

cp -r "${pack_folder}/CMSIS/Include"/* "${dest_folder}/include"

# cmsis-plus

echo
echo "Processing 'cmsis-plus'..."

if [ -n "${use_development_tree}" ]
then
  pack_folder="${use_development_tree}/ilg/arm/cmsis-plus-xpack"
else
  pack_folder="${xpacks_repo_folder}/ilg/cmsis-plus.git"
fi
dest_folder="${xpack_dest_folder}/micro-os-plus"

echo "Creating '${dest_folder}/include'..."
mkdir -p "${dest_folder}/include"

cp -r "${pack_folder}/include"/* "${dest_folder}/include"

echo "Creating '${dest_folder}/src'..."
mkdir -p "${dest_folder}/src"

cp -r "${pack_folder}/src/diag" "${dest_folder}/src"
cp -r "${pack_folder}/src/libc" "${dest_folder}/src"
cp -r "${pack_folder}/src/libcpp" "${dest_folder}/src"
cp -r "${pack_folder}/src/rtos" "${dest_folder}/src"
cp -r "${pack_folder}/src/semihosting" "${dest_folder}/src"
cp -r "${pack_folder}/src/startup" "${dest_folder}/src"

# micro-os-plus-iii

echo
echo "Processing 'micro-os-plus-iii'..."

if [ -n "${use_development_tree}" ]
then
  pack_folder="${use_development_tree}/ilg/portable/micro-os-plus-xpack"
else
  pack_folder="${xpacks_repo_folder}/ilg/micro-os-plus-iii.git"
fi
dest_folder="${xpack_dest_folder}/micro-os-plus"

mkdir -p "${dest_folder}/include"

cp -r "${pack_folder}/include"/* "${dest_folder}/include"

mkdir -p "${dest_folder}/src/rtos/port"

cp -r "${pack_folder}/src/rtos"/* "${dest_folder}/src/rtos/port"

# stm32f4-cmsis
stm_device="stm32f407xx"

echo
echo "Processing 'stm32f4-cmsis'..."

if [ -n "${use_development_tree}" ]
then
  pack_folder="${use_development_tree}/ilg/stm/stm32f4-cmsis-xpack"
else
  pack_folder="${xpacks_repo_folder}/ilg/stm32f4-cmsis.git"
fi
dest_folder="${xpack_dest_folder}/stm32f4-cmsis"

echo "Creating '${dest_folder}/include'..."
mkdir -p "${dest_folder}/include"

cp -r "${pack_folder}/Drivers/CMSIS/Device/ST/STM32F4xx/Include/cmsis_device.h" "${dest_folder}/include"
cp -r "${pack_folder}/Drivers/CMSIS/Device/ST/STM32F4xx/Include/stm32f4xx.h" "${dest_folder}/include"
cp -r "${pack_folder}/Drivers/CMSIS/Device/ST/STM32F4xx/Include/${stm_device}.h" "${dest_folder}/include"
cp -r "${pack_folder}/Drivers/CMSIS/Device/ST/STM32F4xx/Include/system_stm32f4xx.h" "${dest_folder}/include"

echo "Creating '${dest_folder}/src'..."
mkdir -p "${dest_folder}/src"

cp -r "${pack_folder}/Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/system_stm32f4xx.c" "${dest_folder}/src"
cp -r "${pack_folder}/Drivers/CMSIS/Device/ST/STM32F4xx/Source/Templates/gcc/vectors_${stm_device}.c" "${dest_folder}/src"

# stm32f4-hal

echo
echo "Processing 'stm32f4-hal'..."

if [ -n "${use_development_tree}" ]
then
  pack_folder="${use_development_tree}/ilg/stm/stm32f4-hal-xpack"
else
  pack_folder="${xpacks_repo_folder}/ilg/stm32f4-hal.git"
fi
dest_folder="${xpack_dest_folder}/stm32f4-hal"

echo "Creating '${dest_folder}/include'..."
mkdir -p "${dest_folder}/include"

cp -r "${pack_folder}/Drivers/STM32F4xx_HAL_Driver/Inc"/* "${dest_folder}/include"

echo "Creating '${dest_folder}/src'..."
mkdir -p "${dest_folder}/src"

cp -r "${pack_folder}/Drivers/STM32F4xx_HAL_Driver/Src"/* "${dest_folder}/src"

# Almost there...

echo
echo "Changing mode to R/O..."
chmod -R -w "${xpack_dest_folder}"

echo
ls -l "${xpack_dest_folder}"

echo
echo "Done."
