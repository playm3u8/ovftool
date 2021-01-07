FROM buildpack-deps:curl

RUN apt-get update \
 && apt-get install -y locales \
 && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV OVFTOOL_VERSION 4.4.0-16360108

RUN OVFTOOL_INSTALLER=VMware-ovftool-${OVFTOOL_VERSION}-lin.x86_64.bundle \
 && wget -q https://stsharedservices.blob.core.windows.net/pub/ovftool/${OVFTOOL_INSTALLER} \
 && wget -q https://stsharedservices.blob.core.windows.net/pub/ovftool/${OVFTOOL_INSTALLER}.sha256 \
 && sha256sum -c ${OVFTOOL_INSTALLER}.sha256 \
 && sh ${OVFTOOL_INSTALLER} -p /usr/local --eulas-agreed --required \
 && rm -f ${OVFTOOL_INSTALLER}*


CMD [ "ovftool", "--help" ]