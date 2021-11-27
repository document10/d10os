cp /usr/share/zoneinfo/Europe/Bucharest /etc/localtime
echo "Adding user dxvk"
pw user add -n dxvk -c 'document10' -d /home/marlena -G wheel -m -s /usr/local/bin/bash
passwd dxvk
pw groupmod operator -m dxvk
pw groupmod network -m dxvk
pw groupmod wheel -m dxvk
pw groupmod video -m dxvk
pw groupmod sshd -m dxvk
echo "dxvk was succesfully added"
echo "Configuring base system"
freebsd-update fetch
freebsd-update install
pkg bootstrap
pkg update && pkg upgrade
pkg install -y sudo nano git bash neofetch base gcc micro gvfs unzip gzip lzip exa
sysrc dbus_enable=YES
sysrc hald_enable=YES
sysrc sound_load=YES
sysrc snd_hda_load=YES
sysrc moused_enable=YES
sysrc snd_driver=YES
echo 'cuse_load="YES" ' >> /boot/loader.conf
echo "proc /proc procfs rw 0 0">>/etc/fstab
echo "dxvk ALL=(ALL) ALL" >> /usr/local/etc/sudoers.d/dxvk
echo "dxvk now has sudo privileges"
echo "Installing gui"
pkg install -y xf86-input-evdev xorg lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings pcmanfm compton xdg-user-dirs xdg-utils mousepad gnome-backgrounds oss polkit polkit-gnome gtk-arc-themes openbox obconf tint2 menumaker clearlooks dmenu volumeicon xfce4-terminal lxappearance
mmaker openbox -f -t xfterm
sysrc lightdm_enable=YES
echo "mmaker openbox -f -t xfterm &" >> /home/dxvk/.xprofile
echo "openbox --reconfigure &" >> /home/dxvk/.xprofile
echo "compton -f &" >> /home/dxvk/.xprofile
echo "tint2 &" >> /home/dxvk/.xprofile
echo "pcmanfm -d --desktop &" >> /home/dxvk/.xprofile
echo "volumeicon &" >> /home/dxvk/.xprofile
sysrc compton_enable="YES"
sysrc webcamd_enable="YES"
