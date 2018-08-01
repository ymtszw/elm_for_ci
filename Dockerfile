# glibc required as per https://github.com/elm-lang/elm-platform/issues/216
FROM frolvlad/alpine-glibc

# apk gmp make musl-dev gcc are required for building sysconfcpus
# apk yarn depends on nodejs-current, which can be node 9.x
RUN apk update \
  && apk add musl-dev gcc gmp make git bash yarn \
  && addgroup -S elm && adduser -G elm -S elm \
  && git clone https://github.com/obmarg/libsysconfcpus.git /tmp/libsysconfcpus \
  && cd /tmp/libsysconfcpus \
  && ./configure --prefix="/usr/local/sysconfcpus" \
  && make \
  && make install \
  # Removing no longer required packages in order to reducing image size
  && apk del musl-dev gcc \
  && cd /tmp \
  && rm -rf /tmp/libsysconfcpus

USER elm
WORKDIR /home/elm

ENV PATH=/home/elm/.yarn/bin:/usr/local/sysconfcpus/bin:$PATH

RUN yarn global add elm@0.18 elm-test@0.18 \
  && mv /home/elm/.yarn/bin/elm-make /home/elm/.yarn/bin/elm-make-orig \
  # Removing yarn cache in order to reducing image size
  && rm -rf /home/elm/.cache
COPY --chown=elm:elm elm-make /home/elm/.yarn/bin/elm-make