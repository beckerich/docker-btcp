FROM debian:stretch-slim

# Get Dependencies
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y --no-install-recommends apt-utils 
RUN apt-get -y install \
	build-essential pkg-config libc6-dev m4 g++-multilib \
	autoconf libtool ncurses-dev unzip git python \
	zlib1g-dev wget bsdmainutils automake

# Build
RUN git clone https://github.com/BTCPrivate/BitcoinPrivate.git /tmp/coin-daemon
WORKDIR /tmp/coin-daemon
RUN ./btcputil/fetch-params.sh
RUN ./btcputil/build.sh -j$(nproc)

RUN mkdir -p /coin/data

WORKDIR /coin
RUN cp /tmp/coin-daemon/src/btcpd .

EXPOSE 7932
CMD ./btcpd --datadir=/coin/data
