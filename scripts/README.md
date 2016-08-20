# Helper scripts

These scripts were created on macOS, and the ones suffixed with `.command` are specific to macOS; the `.sh` scripts should also be fine on GNU/Linux, and possibly on Windows MSYS2, but it is not guaranteed.

For native Windows, separate PowerShell scripts are required. If you manage to create them, please improve your karma and contribute them back to the community.

## update-xpacks-repo.sh

The xpacks are stored as separate folders in `$HOME/.xpacks`. For now, the format is the original Git, but separate versions will be added as the XCDL tool will be available.

During the first run, the `xpack` branch is cloned into the local folder.

Subsequent runs will pull the latest commit from the current branch.

If, for one reason or another, it is necessary to stick with one older commit for a specific repository, after the initial clone, comment it out to avoid further updates.

## update-xpacks-repo.command

Wrapper for macOS, using the development tree as source; execute it by double clicking in Finder.
