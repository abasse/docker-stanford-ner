FROM openjdk:8-jre

# RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && apt-get install -y nodejs

ENV NODE_VERSION 14.18.2

RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" \
  && case "${dpkgArch##*-}" in \
    amd64) ARCH='x64';; \
    ppc64el) ARCH='ppc64le';; \
    s390x) ARCH='s390x';; \
    arm64) ARCH='arm64';; \
    armhf) ARCH='armv7l';; \
    i386) ARCH='x86';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac \
  && curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
  && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
  # smoke tests
  && node --version \
  && npm --version
  
ADD lib/stanford-ner.jar lib/english.all.3class.distsim.crf.ser.gz lib/english.conll.4class.distsim.crf.ser.gz lib/english.muc.7class.distsim.crf.ser.gz lib/german.distsim.crf.ser.gz lib/german.conll.germeval2014.hgc_175m_600.crf.ser.gz index.js package.json start.sh ./
RUN npm install forever -g && npm install
EXPOSE 9000
CMD ["/bin/bash", "start.sh"]