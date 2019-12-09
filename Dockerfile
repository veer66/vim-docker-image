FROM debian AS build
MAINTAINER Vee Satayamas <vee.sa@protonmail.com>
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential wget libtinfo-dev
RUN wget https://github.com/vim/vim/archive/v8.1.2412.tar.gz && tar -xzvf v8.1.2412.tar.gz
WORKDIR /vim-8.1.2412
RUN ./configure --prefix=/usr/local && make -j8 && make install

FROM debian
RUN apt-get update && apt-get upgrade -y
COPY --from=build /usr/local/bin/ /usr/local/bin/
COPY --from=build /usr/local/share/vim/ /usr/local/share/vim/
