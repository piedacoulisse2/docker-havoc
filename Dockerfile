FROM ubuntu

WORKDIR /teamserver

RUN apt-get update -yq \
&& apt-get install curl gnupg wget git -yq

#RUN echo 'deb http://ftp.de.debian.org/debian bookworm main' >> /etc/apt/sources.list
RUN apt install software-properties-common -yq
RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt-get update -yq
RUN apt install python3.10 python3.10-dev -yq
RUN apt install wget software-properties-common apt-transport-https -yq

#RUN wget https://go.dev/dl/go1.21.4.linux-amd64.tar.gz -O go.tar.gz
#RUN tar -xzvf go.tar.gz -C /usr/local
RUN apt install golang-go -yq


RUN cd ~ && git clone -b dev https://github.com/HavocFramework/Havoc.git

WORKDIR /teamserver/Havoc/teamserver
RUN ls

#RUN go mod download golang.org/x/sys \
#&& go mod download github.com/ugorji/go 
#WORKDIR /teamserver
#RUN make ts-build

#ENTRYPOINT ["/teamserver/havoc", "server" ,"--profile", "/teamserver/profiles/havoc.yaotl","-v","--debug"]