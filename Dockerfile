# Using the latest debian OS
FROM debian:latest 
# Making teamserver directory and moving to it
WORKDIR /teamserver 
# Installing the requirements. 
# Added wget, sudo and setcap (libcap2-bin ) as they are required later in the build stage
RUN apt update -y && apt install -y git build-essential apt-utils cmake \
    libfontconfig1 libglu1-mesa-dev libgtest-dev libspdlog-dev \
    libboost-all-dev libncurses5-dev libgdbm-dev libssl-dev libreadline-dev \
    libffi-dev libsqlite3-dev libbz2-dev mesa-common-dev qtbase5-dev \
    qtchooser qt5-qmake qtbase5-dev-tools libqt5websockets5 \
    libqt5websockets5-dev qtdeclarative5-dev \
    golang-go qtbase5-dev libqt5websockets5-dev python3-dev \
    libboost-all-dev mingw-w64 nasm \
    wget sudo libcap2-bin 
# Cloning the Repo
RUN git clone https://github.com/HavocFramework/Havoc.git .
# Installing Mods
WORKDIR /teamserver/teamserver
RUN go mod download golang.org/x/sys && \
    go mod download github.com/ugorji/go
#Building Teamserver 
WORKDIR /teamserver
RUN make ts-build
#Running Havoc
ENTRYPOINT ["/teamserver/havoc", "server" ,"--profile", "/teamserver/profiles/havoc.yaotl","-v","--debug"]