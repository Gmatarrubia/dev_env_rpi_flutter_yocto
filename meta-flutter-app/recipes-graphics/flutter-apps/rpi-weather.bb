SUMMARY = "Raspi Weather App written in Flutter"
DESCRIPTION = "Raspi Weather App written in Flutter"
AUTHOR = "Gonzalo Matarrubia"
HOMEPAGE = "https://github.com/Gmatarrubia/rpi_weather"
SECTION = "graphics"

LICENSE = "CLOSED"

SRC_URI = "git://github.com/Gmatarrubia/rpi_weather;protocol=https;branch=main"
SRCREV = "main"

S = "${WORKDIR}/git"

PUBSPEC_APPNAME = "rpi_weather"
FLUTTER_RUNTIME = "release"

DEPENDS += "\
    flutter-engine-${FLUTTER_RUNTIME} \
    "

inherit flutter-app
