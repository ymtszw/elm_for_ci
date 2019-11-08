# glibc required as per https://github.com/elm-lang/elm-platform/issues/216
FROM frolvlad/alpine-glibc

# apk gmp make musl-dev gcc are required for building sysconfcpus
RUN apk update \
  && apk upgrade \
  && apk add musl-dev gcc gmp make git openssh bash nodejs-current yarn \
  && git clone https://github.com/obmarg/libsysconfcpus.git /tmp/libsysconfcpus \
  && cd /tmp/libsysconfcpus \
  && ./configure --prefix=/usr/local/sysconfcpus \
  && make \
  && make install \
  # Removing no longer required packages in order to reducing image size
  && apk del musl-dev gcc \
  && cd /tmp \
  && rm -rf /tmp/libsysconfcpus

ENV PATH=/usr/local/sysconfcpus/bin:$PATH

RUN yarn global add \
  elm@0.19.1 \
  elm-test@0.19.1 \
  elm-verify-examples@5 \
  elm-analyse \
  elm-xref \
  uglify-js@3 \
  elm-minify \
  google-closure-compiler \
  && mv /usr/local/bin/elm /usr/local/bin/elm-orig \
  # Removing yarn cache in order to reducing image size
  && yarn cache clean
COPY elm /usr/local/bin/elm
RUN chmod +x /usr/local/bin/elm && ls -lha /usr/local/bin
