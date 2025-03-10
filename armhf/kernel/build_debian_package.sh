#!/bin/sh


ARCH=armhf
VERSION=4.9.189
PKG_NAME=linux-image
TMP=${PKG_NAME}-${VERSION}-${ARCH}
DATE=`date -u`

build_deb()
{
    rm -fr ${TMP}
    mkdir -p ${TMP}/DEBIAN
    mkdir -p ${TMP}/boot/
    mkdir -p ${TMP}/lib/modules/${VERSION}/
    mkdir -p ${TMP}/lib/modules/4.9.0-11-2-armmp/
    mkdir -p ${TMP}/lib/modules/4.9.0-9-2-armmp/

        echo "Adding files from x/"
        cp -drv x/* ${TMP}/

    echo "Package: ${PKG_NAME}-${VERSION}-${ARCH} " > ${TMP}/DEBIAN/control
    echo "Version: $VERSION" >> ${TMP}/DEBIAN/control
    echo "Section: base" >> ${TMP}/DEBIAN/control
    echo "Priority: optional" >> ${TMP}/DEBIAN/control
    echo "Architecture: $ARCH" >> ${TMP}/DEBIAN/control
    echo "Depends:" >> ${TMP}/DEBIAN/control
    echo "Maintainer: $USER <$USER@marvell.com>" >> ${TMP}/DEBIAN/control
    echo "Date: $DATE" >> ${TMP}/DEBIAN/control
    echo "Description: Linux Marvell Kernel" >> ${TMP}/DEBIAN/control
    #cat ${TMP}/DEBIAN/control
    echo "Building deb package"
    dpkg-deb --build ${TMP}

    dpkg -I ${TMP}.deb

}


build_deb
