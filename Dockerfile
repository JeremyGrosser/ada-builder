FROM debian:bullseye

WORKDIR /install
RUN apt-get update && apt-get install -yf git curl make unzip libx11-xcb1 libxft2 dbus

# GNAT Community
RUN curl --silent -L -o gnat-arm-elf-linux64-bin 'https://community.download.adacore.com/v1/7caf13b986227c7a00c64e544e85eee08945b892?filename=gnat-2020-20200818-arm-elf-linux64-bin'
RUN git clone --depth=1 https://github.com/AdaCore/gnat_community_install_script

# Alire
RUN curl --silent -L -o alire.zip https://github.com/alire-project/alire/releases/download/v1.0.0-rc2/alr-1.0.0-rc2-bin-linux.zip
RUN ./gnat_community_install_script/install_package.sh /install/gnat-arm-elf-linux64-bin /opt/GNAT/2020-arm-elf
ENV PATH=/opt/GNAT/2020-arm-elf/bin:$PATH
RUN unzip alire.zip && mv bin/alr /usr/local/bin/alr

# Build user
RUN groupadd build && useradd -m -g build build
RUN rm -rf /install && apt-get clean
USER build
WORKDIR /build
