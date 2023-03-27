SUMMARY = "Raspi Weather App written in Flutter"
DESCRIPTION = "Raspi Weather App written in Flutter"
AUTHOR = "Gonzalo Matarrubia"
HOMEPAGE = "https://github.com/Gmatarrubia/rpi_weather"
SECTION = "graphics"
LICENSE = "CLOSED"

inherit flutter-app

SRC_URI = "git://github.com/Gmatarrubia/rpi_weather;protocol=https;branch=main"
SRCREV = "0b7fedf28a2ed671968866d4b5c8b597622a8b86"

S = "${WORKDIR}/git"

PUBSPEC_APPNAME = "rpi_weather"
FLUTTER_RUNTIME = "release"


DEPENDS += " \
    flutter-engine \
    flutter-pi \
"

RDEPENDS_${PN} += " \
    flutter-pi \
"
