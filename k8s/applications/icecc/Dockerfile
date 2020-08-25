FROM debian
RUN apt-get update \
  && apt-get install -y --no-install-recommends\
    icecc gcc bc bison flex libssl-dev make \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src/app

EXPOSE 10245/TCP 8765/TCP 8766/TCP 8765/UDP