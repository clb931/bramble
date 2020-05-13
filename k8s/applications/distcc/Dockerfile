FROM debian

WORKDIR /use/src/app

RUN useradd -ms /bin/bash distcc

RUN apt-get update && \
    apt-get install -y \
    htop \
    gcc \
    bc \
    bison \
    flex \
    libssl-dev \
    make \
    distcc

ENTRYPOINT [\
  "distccd", \
  "--daemon", \
  "--no-detach", \
  "--user", "distcc", \
  "--port", "3632", \
  "--stats", \
  "--stats-port", "3633", \
  "--log-stderr", \
  "--listen", "0.0.0.0"\
]

# By default the distcc server will accept clients from everywhere.
# Feel free to run the docker image with different values for the
# following params.
CMD [\
  "--allow", "0.0.0.0/0", \
  "--nice", "5", \
  "--jobs", "6" \
]

EXPOSE \
  3632/tcp \
  3633/tcp

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://0.0.0.0:3633/ || exit 1