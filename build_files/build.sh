#!/bin/bash

set -ouex pipefail



### Install packages

dnf5 install -y sddm
dnf5 install -y sway
dnf5 install -y waybar
dnf5 install -y SwayNotificationCenter
dnf5 install -y flatpak

### Dev Tooling installation

dnf5 install -y ghostty
dnf5 install -y tmux
dnf5 install -y podman
dnf5 install -y distrobox

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable sddm.service
