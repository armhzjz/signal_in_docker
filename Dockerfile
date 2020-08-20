FROM    ubuntu:18.04

RUN     set -x && \
        apt-get update && \
        apt-get install -y \
            curl \
            gnupg2 \
            apt-transport-https \
            libx11-xcb-dev \
            libx11-xcb1 \
            libasound2 \
            #libgtk-3-0 \
            #file \
            #elfutils \
            && \
        rm -fr /var/lib/apt/lists/* && \
        :

RUN     curl -s https://updates.signal.org/desktop/apt/keys.asc | apt-key add - && \
        echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | \
        tee -a /etc/apt/sources.list.d/signal-xenial.list && \
        apt-get update && \
        apt-get install -y signal-desktop

RUN     chown root:root /opt/Signal/chrome-sandbox && \
        chmod 4755 /opt/Signal/chrome-sandbox

ENTRYPOINT  ["/usr/bin/signal-desktop"]
