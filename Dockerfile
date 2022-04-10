FROM    ubuntu:18.04

ARG	USER
ARG	UID
ARG	GID
ARG UNAME=${USER}
ARG USERID=${UID}
ARG GROUID=${GID}
RUN	groupadd -g ${GROUID} -o ${UNAME}
RUN	useradd -m -u ${USERID} -g ${GROUID} -o -s /bin/bash ${UNAME}
ENV	DISPLAY :0

RUN     set -x && \
        apt-get update && \
        apt-get install -y \
                curl \
                wget \
                gnupg2 \
                libx11-xcb-dev \
                libx11-xcb1 \
                libasound2 \
                libxshmfence-dev \
                libdrm2 \
                libgbm-dev \
                gosu \
                && \
        rm -fr /var/lib/apt/lists/* && \
        :

## check gosu works
RUN	gosu nobody true

# install signal
RUN     set -x && \
        wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg && \
        cat signal-desktop-keyring.gpg | tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null && \
        echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | \
                tee -a /etc/apt/sources.list.d/signal-xenial.list && \
        apt-get update -y && apt-get install -y signal-desktop

# install tini version v0.19.0
ENV 	TINI_VERSION v0.19.0
ADD	https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN	chmod +x /tini

# change mode and owner of chrome sandbox - otherwise it will not be able to
# launch signal in the container
RUN     chown root:root /opt/Signal/chrome-sandbox && \
        chmod 4755 /opt/Signal/chrome-sandbox

COPY	entrypoint.sh /entrypoint.sh
RUN	chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh", "--no-sandbox", "--use-gl=swiftshader"]
