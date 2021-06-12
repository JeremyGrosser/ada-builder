FROM debian:bullseye

WORKDIR /install
RUN apt-get update && apt-get install -yf git curl make unzip libx11-xcb1 libxft2 dbus

# Download toolchain
RUN curl --silent -L -o gnat-arm-elf-linux64-bin 'https://community.download.adacore.com/v1/2ceb9d1ada2029d79556b710c6c4834cade3749f?filename=gnat-2021-20210519-arm-elf-linux64-bin'
RUN curl --silent -L -o alire.zip https://github.com/alire-project/alire/releases/download/v1.0.0/alr-1.0.0-bin-linux.zip
RUN git clone --depth=1 https://github.com/AdaCore/gnat_community_install_script
COPY SHA256SUM /install/SHA256SUM
RUN sha256sum --check SHA256SUM

# Install GNAT Community
RUN ./gnat_community_install_script/install_package.sh /install/gnat-arm-elf-linux64-bin /opt/GNAT/2021-arm-elf
ENV PATH=/opt/GNAT/2021-arm-elf/bin:$PATH

# Install Alire
RUN unzip alire.zip && mv bin/alr /usr/local/bin/alr

# Add build user
RUN groupadd build && useradd -m -g build build
RUN rm -rf /install && apt-get clean
USER build
WORKDIR /build
