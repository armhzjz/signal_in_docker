FROM    ubuntu:18.04

ARG	UNAME=user
ARG	UID=9000
ARG	GID=9000
RUN	groupadd -g $GID -o $UNAME
RUN	useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
ENV	DISPLAY :0

RUN     set -x && \
        apt-get update && \
        apt-get install -y \
            curl \
            gnupg2 \
            #apt-transport-https \
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

# add signal repository
RUN     curl -s https://updates.signal.org/desktop/apt/keys.asc | apt-key add - && \
        echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | \
	tee -a /etc/apt/sources.list.d/signal-xenial.list && \
	apt update && apt install -y signal-desktop && \
	rm -fr /var/lib/apt/lists/* && \
	:

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
