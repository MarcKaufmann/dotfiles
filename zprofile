
# MacPorts Installer addition on 2022-11-18_at_08:51:51: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Get some macports installs working with pkg-config, so they are found
export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"
# Finished adapting your PATH environment variable for use with MacPorts.
