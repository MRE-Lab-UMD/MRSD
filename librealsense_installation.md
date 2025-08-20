<a name="readme-top"></a>

# Linux Ubuntu Installation


## Table of contents

  * [Linux Kernel Preparation](#linux-kernel-preparation)
  * [Install dependencies](#install-dependencies)
  * [Install librealsense2](#install-librealsense2)
  * [Building librealsense2 SDK](#building-librealsense2-sdk)
  * [Troubleshooting Installation and Patch-related Issues](#troubleshooting-installation-and-patch-related-issues)



## Linux Kernel Preparation

**Since the Realsense SDK 2.55.1 required linux kernel version to be 5.15, 5.19, 6.5, we need to check and prepare for that.**


### 🔍 Check your current kernel version

Run:
```bash
uname -r
```

Example outputs:
- `6.8.0-65-generic` 
- `6.5.0-45-generic` 
- `5.15.0-151-generic` 

**Note: If your version is 5.15, 5.19 or 6.5, you can skip this section, directly perform the SDK installation section**

### 📦 Install Linux 6.5 on Ubuntu 22.04 (Jammy)

1. **Update apt:**
```bash
sudo apt-get update
```

2. **Search for available 6.5 kernels:**
```bash
apt-cache search linux-image-6.5.0 | grep generic
```

(You'll see entries like `linux-image-6.5.0-45-generic`, `linux-headers-6.5.0-45-generic`, etc.)

3. **Install the newest one (example: 6.5.0-45):**
```bash
VER=6.5.0-45
sudo apt-get install -y \
    linux-image-$VER-generic \
    linux-headers-$VER-generic \
    linux-modules-extra-$VER-generic
```
VER=xxx should be the version that aviliable to you.

4. **Reboot:**
```bash
sudo reboot
```
Choose the "Advanced options for Ubuntu" in the GRUB gui, where you can choose the right kernel.

5. **After reboot, confirm:**
```bash
uname -r
# should print 6.5.0-45-generic (or whichever you installed)
```


## Install dependencies

1. Make Ubuntu up-to-date including the latest stable kernel:
   ```sh
   sudo apt-get update && sudo apt-get upgrade && sudo apt-get dist-upgrade
   ```
2. Install the core packages required to build _librealsense_ binaries and the affected kernel modules:
   ```sh
   sudo apt-get install libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev
   ```
   **Cmake Note:** certain _librealsense_ [CMAKE](https://cmake.org/download/) flags (e.g. CUDA) require version 3.8+ which is currently not made available via apt manager for Ubuntu LTS.
3. Install build tools
   ```sh
   sudo apt-get install git wget cmake build-essential
   ```
4. Prepare Linux Backend and the Dev. Environment \
   Unplug any connected Intel RealSense camera and run:
   ```sh
   sudo apt-get install libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev
   ```

## Install librealsense2

1. Download the 2.55.1 version of _librealsense2_  with this link:

   * Download and unzip it in the **"~/MRSD_APP"** folder\
     [IntelRealSense_v2_55_1.zip](https://github.com/IntelRealSense/librealsense/archive/refs/tags/v2.55.1.zip)

2. Run Intel Realsense permissions script from _librealsense-2.55.1_ root directory:
   ```sh
   cd librealsense-2.55.1
   ./scripts/setup_udev_rules.sh
   ```
   Notice: You can always remove permissions by running: `./scripts/setup_udev_rules.sh --uninstall`

3. Build and apply patched kernel modules for:
    * Ubuntu 20/22/24 (focal/jammy/noble) with LTS kernel 5.15, 5.19, 6.5 \
      `./scripts/patch-realsense-ubuntu-lts-hwe.sh`

    **Note:** If you facing this error:
    ```sh
    Failed to insert the patched module. Operation is aborted, the original module is restored
    Verify that the current kernel version is aligned to the patched module version
    The original  uvc  module was reloaded 
    ```
    1. Make sure you choosing the correcr kernel, you check that by runing:
    ```bash
    uname -r
    ```
    2. Make sure you **shut down the Secure Boot** option in your BIOS 


## Building librealsense2 SDK

  * Navigate to _librealsense-2.55.1_ root directory and run:
    ```sh
    mkdir build && cd build
    ```
  * Run cmake configure step, here are some cmake configure examples:\
    The default build is set to produce the core shared object and unit-tests binaries in Debug mode.\
    Use `-DCMAKE_BUILD_TYPE=Release` to build with optimizations.
    ```sh
    cmake ../
    ```
    **Or:** Builds _librealsense2_ along with the demos and tutorials:
    ```sh
    cmake ../ -DBUILD_EXAMPLES=true
    ```

  * Recompile and install _librealsense2_ binaries:
    ```sh
    sudo make uninstall && make clean && make && sudo make install
    ```
    **Note:** Only relevant to CPUs with more than 1 core: use `make -j$(($(nproc)-1)) install` allow parallel compilation.

    **Note:** The shared object will be installed in `/usr/local/lib`, header files in `/usr/local/include`. \
    The binary demos, tutorials and test files will be copied into `/usr/local/bin`

    **Note:** Linux build configuration is presently configured to use the V4L2 backend by default. \
    **Note:** If you encounter the following error during compilation `gcc: internal compiler error` \
    it might indicate that you do not have enough memory or swap space on your machine. \
    Try closing memory consuming applications, and if you are running inside a VM, increase available RAM to at least 2 GB. \
    **Note:** You can find more information about the available configuration options on [this wiki page](https://github.com/IntelRealSense/librealsense/wiki/Build-Configuration).

  
## Troubleshooting Installation and Patch-related Issues

| Error                                                                                                     | Cause                                                                      | Correction Steps                                                                                                               |
|-----------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| ` Multiple realsense udev-rules were found!`                                                              | The issue occurs when user install both Debians and manual from source     | Remove the unneeded installation (manual / Deb)                                                                                |
| `git.launchpad... access timeout`                                                                         | Behind Firewall                                                            | Configure Proxy Server                                                                                                         |
| `dmesg:... uvcvideo: module verification failed: signature and/or required key missing - tainting kernel` | A standard warning issued since Kernel 4.4-30+                             | Notification only - does not affect module's functionality                                                                     |
| `sudo modprobe uvcvideo` produces `dmesg: uvc kernel module is not loaded`                                | The patched module kernel version is incompatible with the resident kernel | Verify the actual kernel version with `uname -r`. Revert and proceed from [Make Ubuntu Up-to-date](#install-dependencies) step |
| Execution of `./scripts/patch-realsense-ubuntu-lts-hwe.sh` fails with `fatal error: openssl/opensslv.h`   | Missing Dependency                                                         | Install _openssl_ package                                                                                                      |

  <p align="right">(<a href="#readme-top">back to top</a>)</p>