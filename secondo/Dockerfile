FROM ubuntu:xenial AS build

RUN apt-get -y update \
  && apt-get -y install curl gcc-5 make flex bison libgsl0-dev libgmp-dev \
    libxml2-dev librecode-dev libjpeg62-dev libboost-all-dev \
    libdb5.3-dev libdb5.3++-dev db5.3-util libreadline-dev libncurses-dev \
    openjdk-8-jdk-headless swi-prolog-nox swi-prolog-java original-awk

RUN groupadd -g 1000 secondo \
  && useradd -u 1000 -g 1000 -m secondo

USER secondo
WORKDIR /home/secondo

RUN curl -O http://dna.fernuni-hagen.de/Secondo.html/files/Sources/secondo-v412-LAT1.tgz

COPY --chown=secondo:secondo build/ .

RUN bash -c "md5sum -c secondo-v412-LAT1.tgz.md5sum \
  && tar xf secondo-v412-LAT1.tgz \
  && ./gen-secondorc \
  && source ~/.secondorc \
  && cd secondo \
  && patch -p1 < ../0001-Remove-unknown-characters-in-Java-source-code.patch \
  && make"

FROM ubuntu:xenial

RUN apt-get -y update \
  && apt-get -y install libgsl2 libgmp10 libxml2 librecode0 libjpeg62 \
    libdb5.3++ openjdk-8-jre-headless swi-prolog-nox swi-prolog-java crudini

RUN groupadd -g 1000 secondo \
  && useradd -u 1000 -g 1000 -m secondo

USER secondo
WORKDIR /home/secondo

RUN mkdir -p secondo/Optimizer secondo/bin

COPY --chown=secondo:secondo run/ .

COPY --chown=secondo:secondo --from=build /home/secondo/.secondorc ./
COPY --chown=secondo:secondo --from=build \
  /home/secondo/secondo/Optimizer secondo/Optimizer/
COPY --chown=secondo:secondo --from=build \
  /home/secondo/secondo/bin/opt \
  /home/secondo/secondo/bin/tmp \
  /home/secondo/secondo/bin/SecondoListener \
  /home/secondo/secondo/bin/SecondoRegistrar \
  /home/secondo/secondo/bin/SecondoConfig.example \
  /home/secondo/secondo/bin/SecondoTTYBDB \
  /home/secondo/secondo/bin/SecondoBDB \
  /home/secondo/secondo/bin/SecondoTTYCS \
  /home/secondo/secondo/bin/SecondoTTYNT \
  /home/secondo/secondo/bin/SecondoConfig.ini \
  /home/secondo/secondo/bin/SecondoCS \
  /home/secondo/secondo/bin/rmlogs \
  /home/secondo/secondo/bin/SecondoCheckpoint \
  /home/secondo/secondo/bin/SecondoMonitor \
  /home/secondo/secondo/bin/ProgressConstants.csv secondo/bin/

CMD ./start-kernel
