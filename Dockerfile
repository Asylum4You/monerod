FROM debian:stable

MAINTAINER Rick Moran <drhayt@gmail.com>

ENV MONEROD_VERSION="v0.10.0"
RUN groupadd -r monero && useradd -r -m -g monero monero
RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends ca-certificates wget bzip2 && \
    mkdir /monero && \
    cd /monero && \
    wget -q -O monero.tar.bz2 https://github.com/monero-project/monero/releases/download/${MONEROD_VERSION}/monero.linux.x64.v0-10-0-0.tar.bz2 && \
    tar -xvjf monero.tar.bz2 && \
    rm monero.tar.bz2

WORKDIR /monero
USER monero

EXPOSE 18080 18081


# Run with --help by default, force user to provide proper arguments.
ENTRYPOINT ["/monero/monerod"]
cmd ["--help"]
