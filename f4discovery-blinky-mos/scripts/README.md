# Helper scripts

These scripts were created on macOS, and the ones suffixed with `.command` are specific to macOS; the `.sh` scripts should also be fine on GNU/Linux, and possibly on Windows MSYS2, but it is not guaranteed.

For native Windows, separate PowerShell scripts are required. If you manage to create them, please improve your karma and contribute them back to the community.

## update-xpacks.sh

Recreate the content of the `xpacks` folder.

The resulting folder is marked as read/only.

This script requires the helper script from parent `scripts/update-xpacks-helper.sh`.

## update-xpacks.command

Wrapper for macOS; execute it by double clicking in Finder.
