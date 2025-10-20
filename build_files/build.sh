#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# remove unwanted packages
dnf5 remove firefox firefox-langpacks gnome-software gnome-software-ostree gnome-tour yelp malcontent-control -y

# this installs a package from fedora repos
dnf5 install dnf5-plugins plasma-systemsettings plasma-integration kvantum btop distrobox fastfetch gamescope mangohud rocm-smi steam-devices wine libguestfs-tools libvirt-daemon-config-network libvirt-daemon-kvm python3-libguestfs qemu-kvm virt-install virt-manager virt-top virt-viewer -y

# rpm fusion
dnf5 -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf5 -y install steam
dnf5 -y remove rpmfusion-free-release rpmfusion-nonfree-release

rm /opt
mkdir /opt
#mkdir -p "/var/opt" && ln -s "/var/opt" "/opt"
dnf5 -y install https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.18.1/Heroic-2.18.1-linux-x86_64.rpm
#dnf5 -y install https://kojipkgs.fedoraproject.org//packages/gamescope/3.16.2/1.fc42/x86_64/gamescope-3.16.2-1.fc42.x86_64.rpm

#dnf5 -y copr enable atim/heroic-games-launcher
dnf5 -y copr enable ilyaz/LACT
#dnf5 -y install heroic-games-launcher-bin
dnf5 -y install lact
#dnf5 -y copr disable atim/heroic-games-launcher
dnf5 -y copr disable ilyaz/LACT

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable lactd
