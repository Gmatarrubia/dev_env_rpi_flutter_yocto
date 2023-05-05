
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://null-sound-safety.patch \
"

PACKAGECONFIG:append:pn-flutter-engine = " profile release vulkan"
