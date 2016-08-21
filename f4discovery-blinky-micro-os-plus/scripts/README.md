# Helper scripts

These scripts were created on macOS, and the ones suffixed with `.command` are specific to macOS; the `.sh` scripts should also be fine on GNU/Linux, and possibly on Windows MSYS2, but it is not guaranteed.

For native Windows, separate PowerShell scripts are required. If you manage to create them, please consider improving your karma and contribute them back to the community.

## generate.sh

Recreate the content of the `generated` folder.

The resulting folder is marked as read/only.

This script requires the helper script from parent `scripts/generate-helper.sh`.

## generate.command

Wrapper for macOS, using the development tree as source; update the absolute address of the development tree is cloned and execute it by double clicking in Finder.
