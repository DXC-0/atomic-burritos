#!/bin/bash

set -ouex pipefail

### Install packages

dnf5 install -y sddm
dnf5 install -y sway
dnf5 install -y flatpak
dnf5 install -y ghostty
dnf5 install -y 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
