#FROM quay.io/fedora/fedora-bootc:41
FROM quay.io/fedora/fedora-silverblue:41
#FROM quay.io/fedora/fedora-silverblue:42

# We'll use flatpak version of firefox and having both installed can be
# confusing:
RUN dnf remove -y firefox firefox-langpacks

# Install rpmfusion GPG keys before anything else:
# RUN dnf install -y distribution-gpg-keys \
RUN rpmkeys --import \
  /usr/share/distribution-gpg-keys/rpmfusion/RPM-GPG-KEY-rpmfusion-nonfree-fedora-41 \
  /usr/share/distribution-gpg-keys/rpmfusion/RPM-GPG-KEY-rpmfusion-free-fedora-41

# Install RPMFusion:
RUN dnf install -y --setopt=localpkg_gpgcheck=1 \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-41.noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-41.noarch.rpm \
  && dnf config-manager setopt fedora-cisco-openh264.enabled=1

RUN dnf install -y --skip-unavailable \
  # docker-buildx-plugin \
  # docker-ce \
  # docker-ce-cli \
  # docker-compose-plugin \
  @virtualization \
  bootc \
  brightnessctl \
  containerd.io \
  dex-autostart \
  distrobox \
  fzf \
  gnome-boxes \
  gnome-network-displays \
  grim \
  grimshot \
  gstreamer1-plugins-bad-free-extras \
  gstreamer1-plugins-bad-freeworld \
  gstreamer1-plugins-ugly \
  gstreamer1-vaapi \
  i3status \
  libavcodec-freeworld \
  libva-utils \
  lxpolkit \
  mesa-va-drivers-freeworld \
  mesa-vdpau-drivers-freeworld \
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
