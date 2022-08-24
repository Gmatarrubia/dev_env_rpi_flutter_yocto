
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

DEPENDS += "${PYTHON_PN}-pycryptodome-native"
DEPENDS:remove = "python3-m2crypto-native"

SRC_URI:remove = "file://crda-4.14-python-3.patch"
SRC_URI:remove = "file://use-target-word-size-instead-of-host-s.patch"
SRC_URI:remove = "file://fix-issues-when-USE_OPENSSL-1.patch"
SRC_URI:remove = "file://fix-gcc-6-unused-variables.patch"

SRC_URI += " \
    file://0001-nativepython3.patch \
"
