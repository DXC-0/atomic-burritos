#!/bin/bashhttps://github.com/DXC-0/atomic-burritos/blob/main/build_files/build.sh

set -ouex pipefail

### Nvidia Open Installation

--from=ghcr.io/ublue-os/akmods-nvidia-open:main-42 /rpms/ /tmp/rpms
find /tmp/rpms
rpm-ostree install /tmp/rpms/ublue-os/ublue-os-nvidia*.rpm
sed -i '0,/enabled=0/{s/enabled=0/enabled=1/}' /etc/yum.repos.d/nvidia-container-toolkit.repo
sed -i '0,/enabled=0/{s/enabled=0/enabled=1\npriority=90/}' /etc/yum.repos.d/negativo17-fedora-nvidia.repo 
rpm-ostree install /tmp/rpms/kmods/kmod-nvidia*.rpm libnvidia-fbc libva-nvidia-driver nvidia-driver nvidia-driver-cuda nvidia-modprobe nvidia-persistenced nvidia-settings nvidia-container-toolkit
semodule --verbose --install /usr/share/selinux/packages/nvidia-container.pp

echo '

# Nvidia modesetting support. Set to 0 or comment to disable kernel modesetting
# support. This must be disabled in case of SLI Mosaic.

options nvidia-drm modeset=1 fbdev=1

' > /usr/lib/modprobe.d/nvidia-modeset.conf

cp /usr/lib/modprobe.d/nvidia-modeset.conf /etc/modprobe.d/nvidia-modeset.conf


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
