# dev_env_rpi_flutter_yocto
### Development environment for building flutter apps for Raspberry Pi 3b+ based on yocto images.
### Also, you can develop the flutterpi distro itself.

# Characteristics
This devenv has been designed with the following prerequisites:
- Widely compatible with host systems.
- As easy as posible.
- Easy to manage remotely.

# Basic use
The devenv runs natively on Ubuntu 20.04 distros. If your system runs Ubuntu 20.04, you will be able to use it natively.
Otherwise, you have some other options:
- Virtual Machine with Ubuntu 20.04
- Install WSL2 (only for Windows)
- Install docker (this works even in WSL2, but not recommended in this case)

### For using it in docker just add this step. Otherwise, you can skip this step.
**Note:** Before run this step, you might be sure that:
- Docker is installed
- Docker service/daemon is running
- Your user is un docker group (sudo usermod -aG <yourUser> docker)

```
./init-docker-env.sh
```
### Installing dependencies
```  
./installDevDeps.sh
```

### Build
**Note:** See ./build.sh --help for further information.
```  
./build.sh
```

### Cleaning
```  
./cleanAll.sh
```
