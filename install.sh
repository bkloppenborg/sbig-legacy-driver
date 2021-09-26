#!/bin/bash

SBIG_VERSION="4.75.0"
SBIG_SOVERSION="4"

FIRMWARE_INSTALL_DIR="/lib/firmware/"
LIB_INSTALL_DIR="/usr/lib/"
INC_INSTALL_DIR="/usr/include/"
RULES_INSTALL_DIR="/etc/udev/rules.d"
CMAKE_MODULE_DIR=`find /usr/share/cmake-* | head -1`"/Modules/"

# Pick the correct driver based upon the underlying architecture
DRIVER=""
MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
  DRIVER="./drivers/x86/lib64/libsbigudrv.so"
elif [ ${MACHINE_TYPE} == 'i686' ]; then
  DRIVER="./drivers/x86/lib32/libsbigudrv.so"
elif [ ${MACHINE_TYPE} == 'aarch64' ]; then
  DRIVER="./drivers/arm/libsbigudrv.so"
else
    echo "Unknown processor architecture. Quitting installation"
    exit
fi

# Install the driver, header, firmware, UDEV rules, and find script
# Driver
sudo cp -f ${DRIVER} ${LIB_INSTALL_DIR}/libsbigudrv.so.${SBIG_VERSION}
sudo ln -s ${LIB_INSTALL_DIR}/libsbigudrv.so.${SBIG_VERSION} ${LIB_INSTALL_DIR}/libsbigudrv.so.${SBIG_SOVERSION}
sudo ln -s ${LIB_INSTALL_DIR}/libsbigudrv.so.${SBIG_SOVERSION} ${LIB_INSTALL_DIR}/libsbigudrv.so
# Header
sudo cp -f drivers/sbigudrv.h ${INC_INSTALL_DIR}/
# Firmware
sudo cp -f firmware/* ${FIRMWARE_INSTALL_DIR}
# UDEV rules
sudo cp -f udev/* ${RULES_INSTALL_DIR}
# CMake Find script
sudo cp -f cmake/FindSBIGUDRV.cmake ${CMAKE_MODULE_DIR}/


# Reload UDEV rules:
sudo udevadm control --reload
