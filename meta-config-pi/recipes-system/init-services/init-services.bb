DESCRIPTION = "Setup services files"
SECTION = "Init"
LICENSE = "CLOSED"
FILESEXTRAPATHS:append:flutterpi = " ${THISDIR}/files"

SRC_URI = "file://flutter-app.service"

FILES:${PN} = " \
    ${base_libdir}/systemd/system/flutter-app.service \
    ${sysconfdir}/systemd/system/default.target.wants \
    "

do_install() {
    install -d ${D}${base_libdir}/systemd/system/
    install -d ${D}${sysconfdir}/systemd/system/default.target.wants/
    install -m 0755 ${WORKDIR}/flutter-app.service ${D}${base_libdir}/systemd/system/flutter-app.service
    ln -r -s ${D}${base_libdir}/systemd/system/flutter-app.service  ${D}${sysconfdir}/systemd/system/default.target.wants/
}