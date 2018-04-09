FROM debian:stretch

# Get Dependencies
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y --no-install-recommends apt-utils 

RUN apt-get -y install \
		build-essential pkg-config libc6-dev m4 g++-multilib \
		autoconf libtool ncurses-dev unzip git python \
		zlib1g-dev wget bsdmainutils automake

RUN git clone https://github.com/BTCPrivate/BitcoinPrivate.git /tmp/bitcoin-private && \
	cd /tmp/bitcoin-private && \
	./btcputil/build.sh -j$(nproc) && \
	./btcputil/fetch-params.sh

RUN mkdir -p /bitcoin-private/data
WORKDIR /bitcoin-private

RUN cp /tmp/bitcoin-private/src/btcpd .

CMD btcpd --datadir=/bitcoin-private/data
