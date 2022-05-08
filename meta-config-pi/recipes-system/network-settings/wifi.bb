DESCRIPTION = "Setup network wifi"
SECTION = "Network"
LICENSE = "CLOSED"
FILESEXTRAPATHS:append:flutterpi := " ${THISDIR}/${PN}"

SRC_URI = " \
    file://interfaces \
    file://wpa_supplicant.conf \
    "

FILES:${PN} = " \
    ${sysconfdir}/wpa_supplicant.conf \
    ${sysconfdir}/network/interfaces \
    "

do_install() {
    install -d ${D}${sysconfdir}/network
    install -m 0755 ${WORKDIR}/wpa_supplicant.conf ${D}${sysconfdir}
    install -m 0755 ${WORKDIR}/interfaces  ${D}${sysconfdir}/network/
}