FROM scratch
ADD debian.tgz /

RUN apt-get update \
&& apt-get install -qq -y --no-install-recommends \
  software-properties-common \
  autoconf \
  build-essential \
  curl \
  file \
  git \
  libasound2-dev \
  libcups2-dev \
  libfontconfig1-dev \
  libx11-dev \
  libxext-dev \
  libxrandr-dev \
  libxrender-dev \
  libxt-dev \
  libxtst-dev \
  unzip \
  wget \
  zip \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /openjdk-linux-x86 \
&& useradd -ms /bin/bash build \
&& chown build /openjdk-linux-x86

USER build
WORKDIR /openjdk-linux-x86
RUN git clone https://github.com/OpenIndex/openjdk-linux-x86.git /openjdk-linux-x86 \
&& git checkout jdk11

ENTRYPOINT ["/usr/bin/linux32", "--", "/openjdk-linux-x86/build.sh"]
