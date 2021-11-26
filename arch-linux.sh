#!/bin/bash
#change this to your region i.e. Australia/US etc
ln -sf /usr/share/zoneinfo/Europe/Bucharest /etc/localtime
hwclock --systohc
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "Configuring network"
echo "archmc" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 archmc.localdomain archmc" >> /etc/hosts
cat /etc/hosts
echo "Root password:"
passwd
echo "Installing base packages"
pacman -Syu --noconfirm linux-firmware git neofetch nano grub efibootmgr networkmanager network-manager-applet reflector base-devel linux-headers ipset os-prober ntfs-3g terminus-font openssh bash-completion dnsutils ufw iptables micro exa
clear
echo " The following section will allow you to select your gpu driver."
echo "Nvidia:"
pacman -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader xf86-video-nouveau
echo "AMD:"
pacman -S lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader xf86-video-amdgpu
echo "Intel:"
pacman -S lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader xf86-video-intel
echo "Virtualbox"
pacman -S virtualbox-guest-utils 	xf86-video-vmware
echo "Configuring grub bootloader"
#uefi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

#mbr
#grub-install --target=i386-pc /dev/sda # replace sda with your disk name, not the partition
#grub-mkconfig -o /boot/grub/grub.cfg


echo "Configuring base services"
systemctl enable --now NetworkManager
systemctl enable --now sshd
systemctl enable --now iptables
systemctl enable --now ip6tables
systemctl enable --now ufw
ufw enable
ufw allow ssh
echo "Creating a new user"
useradd -m doc10
echo "Password for doc10:"
passwd doc10
echo "doc10 ALL=(ALL) ALL" >> /etc/sudoers.d/doc10
echo "doc10 now has sudo privilleges."
usermod -aG wheel,audio,video,optical,storage doc10
echo "Creating swapfile"
#You can change the swap file to as much as needed
#For systems with less ram,make the swapfile big(2048M or similar)
fallocate -l 1024M /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "Loading swapfile"
echo "/swapfile	none	swap	defaults	0	0" >> /etc/fstab
cat /etc/fstab
echo "kernel.sysrq = 1" >> /etc/sysctl.d/99.sysctl.conf
echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.d/99.sysctl.conf
echo "vm.swappiness = 5" >> /etc/sysctl.d/99.sysctl.conf
echo "Swapfile settings"
cat /etc/sysctl.d/99.sysctl.conf
free -m
echo "Installing openbox"
pacman --noconfirm -S xorg xorg-server xterm firefox lightdm  lightdm-gtk-greeter lightdm-gtk-greeter-settings archlinux-wallpaper pcmanfm avahi xdg-user-dirs xdg-utils gedit bluez bluez-utils alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack sof-firmware blueman arc-solid-gtk-theme arc-gtk-theme arc-icon-theme openbox obconf tint2 picom lxappearance xarchiver unzip gzip lzip menumaker volumeicon mousepad xfce4-terminal cups
systemctl enable lightdm
systemctl enable bluetooth
systemctl enable cups.service
echo "mmaker openbox -f -t xfterm &" >> /home/doc10/.xprofile
echo "openbox --reconfigure &" >> /home/doc10/.xprofile
echo "compton -f &" >> /home/doc10/.xprofile
echo "tint2 &" >> /home/doc10/.xprofile
echo "pcmanfm -d --desktop &" >> /home/doc10/.xprofile
echo "volumeicon &" >> /home/doc10/.xprofile
echo "Final configuration"
mkinitcpio -P
echo "D10OS installed succesfully."
