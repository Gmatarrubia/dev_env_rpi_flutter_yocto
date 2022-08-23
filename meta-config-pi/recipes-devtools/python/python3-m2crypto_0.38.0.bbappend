
FILESEXTRAPATHS:prepend := "${THISDIR}/python-m2crypto:"

SRC_URI:remove = "file://avoid-host-contamination.patch"
SRC_URI += " \
    file://0001-setup.py-address-openssl-3.x-build-issue.patch \
    file://0002-avoid-host-contamination.patch \
"
