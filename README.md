#  D10OS
Installation script for arch,freebsd and debian(coming soon)
#  What you will get:
D1OS uses openbox for a lightweight WM alongside tint2 for the dock,pcmanfm for a file manager ar well as for managing desktop icons and background and lxappearance for managing the desktop appearance.Preinstalled applications include xfce terminal,mousepad,micro,exa and volumeicon for easily managing volume from the taskbar.
The menu on openbox is configured using menumaker to ensure that you have access to all apps you need.Lightdm is used as a display manager.
#  Prerequisites
## All distros/OSes
The region is defaulted to mine but you will need to change it.Also for some OSes you will need to change the username to your nonroot username.
## Arch linux:
This script assumes you know to install arch up to the chroot(partitioning and base packages).The rest is handled by the script.
In order for the script to work make sure that the following lines from /etc/pacman.conf:


`[multilib]`


`Include = /etc/pacman.d/mirrorlist`


You can also uncomment these lines for faster downloads as well as color support within pacman:


`ParallelDownloads = 5


Color`


You don't need to run `pacman -Syu` as the script will run it before installing anything.
For boot loader there is a section for `MBR`.If your system uses that instead of `UEFI` comment the lines after #uefi untill #mbr and uncomment the lines after #mbr.
