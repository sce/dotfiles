## Flatpak plugins

In order to get plugins picked up by the OBS flatpak installation e.g. this works for
motion-transition plugin:

    $ find ~/.var|grep motion-transition

    .var/app/com.obsproject.Studio/config/obs-studio/plugins/motion-transition
    .var/app/com.obsproject.Studio/config/obs-studio/plugins/motion-transition/bin
    .var/app/com.obsproject.Studio/config/obs-studio/plugins/motion-transition/bin/64bit
    .var/app/com.obsproject.Studio/config/obs-studio/plugins/motion-transition/bin/64bit/motion-transition.so
    .var/app/com.obsproject.Studio/config/obs-studio/plugins/motion-transition/data
    .var/app/com.obsproject.Studio/config/obs-studio/plugins/motion-transition/data/locale
    .var/app/com.obsproject.Studio/config/obs-studio/plugins/motion-transition/data/locale/zh-TW.ini
    .var/app/com.obsproject.Studio/config/obs-studio/plugins/motion-transition/data/locale/en-US.ini
