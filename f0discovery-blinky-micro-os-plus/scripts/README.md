# Helper scripts

These scripts were created on macOS, and the ones suffixed with `.command` are specific to macOS; the `.sh` scripts should also be fine on GNU/Linux, Windows MSYS2, and on the new [Windows Subsystem for Linux](https://msdn.microsoft.com/commandline/wsl/about).

For those who insist on native Windows, separate PowerShell scripts would be required, but considering Microsoft's move towards Linux, this would probably not be worth the effort. Anyway, if you manage to create them, please consider improving your karma and contribute them back to the community.

## Prerequisites

To run these scripts it is necessary to first download the [`xpacks/scripts`](https://github.com/xpacks/scripts) project, as explained in the project README.

## generate.sh

Recreate the content of the `generated` folder.

The resulting folder is marked as read/only.

This script requires the helper script from parent `scripts/generate-helper.sh`.

## generate.mac.command

Wrapper for macOS, using the development tree as source; update the absolute address of the development tree is cloned and execute it by double clicking in Finder.
