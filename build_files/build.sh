#!/bin/bashhttps://github.com/DXC-0/atomic-burritos/blob/main/build_files/build.sh

set -ouex pipefail

### Install

dnf5 -y copr enable ublue-os/packages
dnf5 -y copr enable ublue-os/staging
dnf5 -y config-manager setopt "*akmods*".priority=1
dnf5 -y config-manager setopt "*staging*".exclude="scx-scheds kf6-* mesa* mutter* rpm-ostree* systemd* gnome-shell gnome-settings-daemon gnome-control-center gnome-software libadwaita tuned*"


### Proprietary packages : 

curl -Lo /etc/yum.repos.d/negativo17-fedora-multimedia.repo https://negativo17.org/repos/fedora-multimedia.repo
sed -i '0,/enabled=1/{s/enabled=1/enabled=1\npriority=90/}' /etc/yum.repos.d/negativo17-fedora-multimedia.repo

### Install packages

dnf5 install -y sddm
dnf5 install -y sway
dnf5 install -y waybar
dnf5 install -y SwayNotificationCenter
dnf5 install -y wofi
dnf5 install -y flatpak

### Dev Tooling installation

dnf5 install -y tmux
dnf5 install -y podman
dnf5 install -y distrobox 

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable sddm.service
