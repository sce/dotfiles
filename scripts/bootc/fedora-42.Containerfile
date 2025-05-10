###############################################################################
#FROM quay.io/fedora/fedora-bootc:42
FROM quay.io/fedora/fedora-silverblue:42 AS SWAY

# We'll use flatpak version of firefox and having both installed can be
# confusing:
RUN dnf remove -y firefox firefox-langpacks

RUN dnf install -y \
  # docker-buildx-plugin \
  # docker-ce \
  # docker-ce-cli \
  # docker-compose-plugin \
  @virtualization \
  bootc \
  brightnessctl \
  dex-autostart \
  distrobox \
  fzf \
  gnome-boxes \
  gnome-network-displays \
  grim \
  grimshot \
  gstreamer1-plugins-bad-free-extras \
  gstreamer1-vaapi \
  i3status \
  libva-utils \
  lxpolkit \
  obs-studio \
  pamixer \
  perl \
  rofi-wayland \
  ruby \
  slurp \
  sway \
  sway-wallpapers \
  swaybg \
  swayidle \
  swaylock \
  SwayNotificationCenter \
  tmux \
  vdpauinfo \
  waybar \
  wlsunset \
  wofi \
  zenity \
  && dnf clean all

WORKDIR /

COPY local-config.d/sysctl /etc/
COPY local-config.d/systemd /etc/systemd/

###############################################################################
FROM SWAY AS RPMFUSION

# Install rpmfusion GPG keys before anything else:
# RUN dnf install -y distribution-gpg-keys \
RUN rpmkeys --import \
  /usr/share/distribution-gpg-keys/rpmfusion/RPM-GPG-KEY-rpmfusion-nonfree-fedora-42 \
  /usr/share/distribution-gpg-keys/rpmfusion/RPM-GPG-KEY-rpmfusion-free-fedora-42

# Install RPMFusion:
RUN dnf install -y --setopt=localpkg_gpgcheck=1 \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-42.noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-42.noarch.rpm \
  && dnf config-manager setopt fedora-cisco-openh264.enabled=1

RUN dnf install -y \
  gstreamer1-plugins-bad-freeworld \
  gstreamer1-plugins-ugly \
  libavcodec-freeworld \
  mesa-va-drivers-freeworld \
  mesa-vdpau-drivers-freeworld

###############################################################################
FROM RPMFUSION AS MULLVAD

# Add Mullvad repository:
RUN dnf config-manager addrepo \
  --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo

# /opt points to /var/opt and since /var will be mounted later we need to do
# something else:
RUN rm /opt && mkdir -p /opt \
  && dnf install -y mullvad-vpn
