FROM debian:11

RUN apt-get update -yq \
&& apt-get install curl gnupg wget git -yq

RUN echo 'deb http://ftp.de.debian.org/debian bookworm main' >> /etc/apt/sources.list
RUN apt-get update -yq
RUN apt install python3-dev python3.10-dev libpython3.10 libpython3.10-dev python3.10 -yq
RUN apt install wget software-properties-common apt-transport-https -yq
RUN wget https://golang.org/dl/go1.17.linux-amd64.tar.gz
RUN tar -zxvf go1.17.linux-amd64.tar.gz -C /usr/local/
RUN echo "export PATH=/usr/local/go/bin:$PATH" | tee /etc/profile.d/go.sh -q \
&& source /etc/profile.d/go.sh -yq \
&& echo "export PATH=/usr/local/go/bin:$PATH" | tee -a $HOME/.profile source -q \
&& source $HOME/.profile -q

RUN git clone https://github.com/HavocFramework/Havoc.git
RUN cd Havoc

RUN cd teamserver
RUN go mod download golang.org/x/sys
RUN go mod download github.com/ugorji/go
RUN cd ..

RUN make ts-build

CMD ["./havoc", "server", "--profile", "./profiles/havoc.yaotl", "-v", "--debug"]