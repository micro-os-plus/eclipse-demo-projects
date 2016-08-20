#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

script=$0
if [[ "${script}" != /* ]]
then
  # Make relative path absolute.
  script=$(pwd)/$0
fi

parent="$(dirname ${script})"

bash "$parent/update-xpacks.sh" --dev-tree "/Users/ilg/My Files/MacBookPro Projects/uOS/micro-os-plus-iii-tree.git"
