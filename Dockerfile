FROM ubuntu:16.04
ENV HOME="/wine"
RUN apt-get update \
    && apt-get install -y \
        software-properties-common \
        wget \
    && dpkg --add-architecture i386 \
    && add-apt-repository ppa:wine/wine-builds \
    && apt-get update \
    && apt-get install -y --install-recommends winehq-staging \
    && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
        -O /usr/bin/winetricks \
    && chmod +rx /usr/bin/winetricks \
    && mkdir -p $HOME/.cache/wine \
    && wget https://dl.winehq.org/wine/wine-mono/4.6.4/wine-mono-4.6.4.msi \
        -O $HOME/.cache/wine/wine-mono-4.6.4.msi \
    && wget https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86.msi \
        -O $HOME/.cache/wine/wine_gecko-2.47-x86.msi \
    && wget https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86_64.msi \
        -O $HOME/.cache/wine/wine_gecko-2.47-x86_64.msi
VOLUME ["/wine"]
COPY ./entrypoint.sh /usr/bin/entrypoint
ENTRYPOINT ["/usr/bin/entrypoint"]
