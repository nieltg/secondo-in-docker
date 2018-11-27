FROM ubuntu:16.04

RUN apt-get -y update \
  && apt-get -y install curl build-essential flex bison openjdk-8-jdk-headless \
  libdb5.3 libdb5.3-dev libdb5.3++ libdb5.3++-dev db5.3-util \
  libjpeg62 libjpeg62-dev libgsl0-dev swi-prolog-nox swi-prolog-java \
  libreadline-dev librecode-dev libgmp-dev libncurses-dev libxml2-dev \
  libboost-all-dev original-awk

RUN groupadd -g 1000 secondo \
  && useradd -u 1000 -g 1000 -m secondo

USER secondo
WORKDIR /home/secondo

RUN curl -O http://dna.fernuni-hagen.de/Secondo.html/files/Sources/secondo-v412-LAT1.tgz \
  && tar xf secondo-v412-LAT1.tgz

COPY --chown=secondo:secondo . .

RUN bash -c "./secondo-rc.bash \
  && source ~/.secondorc \
  && cd secondo \
  && patch -p1 < ../0001-Remove-unknown-characters-in-Java-source-code.patch \
  && make"
