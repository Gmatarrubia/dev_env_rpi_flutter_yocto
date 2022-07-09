# Flutterpi OS based on yocto

This is the development environment of flutterpi. A raspberry pi linux distro based on poky (yocto) which runs flutter apps. This is very useful for several use cases like: kiosk machines, vending machines, info panels, and a lot of different HMIs. It allows you to develop a HMI quickly, repeatible and fully customizable.

## Dev env characteristics

This devenv has been designed with the following prerequisites:

- Widely compatible with host systems.
- As easy as posible.
- Good documented.
- Easy to manage remotely.
- Flexible and multipurpose.

## Basic use

The devenv runs natively on Ubuntu 20.04/22.04 distros. If your system runs Ubuntu 20.04/22.04, you will be able to use it natively. Otherwise, you have these other options:

- Install docker (recommended)
- Visual Code: Dev in container (also recommended, only linux host)
- Virtual Machine with Ubuntu 20.04/22.04
- Install WSL2 (only for Windows)

### Installing - Docker method. Otherwise, you can skip this step.

**Note:** Before running this step, you should be sure of:

- Docker is installed
- Docker service/daemon is running
- Your user is in the docker group `sudo usermod -aG $(whoami) docker`

The script will try to install/config docker in case it wasn't installed. If installation or config is needed, you will have to reboot your host and launch the script again.

```bash
./init-docker-env.sh
```

### Installing - Ubuntu 20.04/22.04 native method

**Note:** The installation step has to be used just the very first time.

```bash
./installDevDeps.sh
```

## Build

You can build the entire image with settings by default. The result will a image bootable in a Raspberry Pi which runs a flutter app at the beggining. Just type:

```bash
./build.sh
# Building the image from scratch could take hours. Be patient
```

Before starting the building, you can set the Wi-Fi settings (ssid + pass).

```bash
./build.sh --wifi-interactive
```

**Note:** This will be skipped if you set the enviroment variables `WIFISSID` and `WIFIPASS` since the script will config the Wi-Fi automatically.

**Note:** See ./build.sh --help for further information.

## Custom build command

Build script let you enter your custom bitbake commands. This can be done by using the -bc or --bitbake-cmd argument followed by the double-quoted command. This argument must be placed in the last position of command in order to avoid conflicts. See some examples:

```bash
./build.sh --bitbake-cmd bitbake -s | grep flutter
./build.sh -bc bitbake -D wifi -c clean
./build.sh --bitbake-cmd bitbake-layers show-layers
./build.sh -j 8 -wi --bitbake-cmd bitbake-layers show-layers
```

## Interactive session

This is a powerful way to debug and develop either your recipes or your flutter apps. If you are interested in open an interative session run this:

```bash
./build.sh --shell

```

Once you are inside the `shell` you will be able to use commands like:

- bitbake
- bitbake-getvar
- bitbake-layers
- devtool

## Cleaning

```bash
./cleanAll.sh
# Keep in mind it could be dangerous in case you have unsaved changes.
git clean -fdx
```

## License

Thank you to @jwinarske. This project is based on his work.
Check it out here: https://github.com/meta-flutter/meta-flutter-rpi

Check the LICENSE file to find detailed info about the license of this project.
