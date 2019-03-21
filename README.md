This repository contains an example about how to build OpenJDK 11 for Linux x86 (IA-32) on a Linux x86-64 system with [Docker](https://www.docker.com/).

In the first step run `sudo build-image.sh` in order to create a Debian i386 root filesystem. You might use other already existing images from [Docker Hub](https://hub.docker.com/) as well and update the `Dockerfile` accordingly. But I did not test this yet.

Afterwards execute `build-openjdk.sh` in order to start the build process. If everything went fine, the created OpenJDK packages are stored in the newly created `package` folder.
