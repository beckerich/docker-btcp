FROM debian:jessie-slim

# Get Dependencies
RUN set -x && \
		 apt-get update && \
		 apt-get -y install \
		 build-essential pkg-config libc6-dev m4 g++-multilib \
		 autoconf libtool ncurses-dev unzip git python \
		 zlib1g-dev wget bsdmainutils automake

RUN git clone https://github.com/BTCPrivate/BitcoinPrivate.git && \
	cd BitcoinPrivate && \
	./btcputil/build.sh -j$(nproc) && \
	./btcputil/fetch-params.sh
