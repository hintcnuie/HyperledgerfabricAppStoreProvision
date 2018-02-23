#!/usr/bin/env bash

apt-get update
apt-get -y upgrade
apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88 
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>Configure golang 1.8.3 start >>>>>>>>>>>>>>>>>>>>"
# download go 1.8.3
wget -q https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
tar -xvf go1.8.3.linux-amd64.tar.gz
cp -R  go /usr/local
#GO VARIABLES
export GOROOT=/usr/local/go
export GOPATH=/home/ubuntu/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
echo "export GOROOT=/usr/local/go"   >>  /etc/profile
echo "export GOPATH=/home/ubuntu/go" >> /etc/profile
echo "export PATH=$PATH:$GOPATH/bin:$GOROOT/go/bin" >> /etc/profile
echo $GOPATH
mkdir -p $GOPATH/src/github.com/hyperledger
#END GO VARIABLES
go version
go env
echo "<<<<<<<<<<<<<<<<<<<<<<Configure golang 1.8.3 end<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
echo ">>>>>>>>>>>>>>>>>>>>>>Start to install Node.js v6.x:>>>>>>>>>>>>>>>>>>>>>>>>>"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs
npm install npm@3.10.10 -g
echo ">>>>>>>>>>>>>>>>>>>>>>Start to configure Docker CE>>>>>>>>>>>>>>>>>>>>>>>>>>>"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-cache policy docker-ce
apt-get install -y docker-ce
groupadd docker
usermod -aG docker $USER
usermod -aG docker ubuntu
systemctl enable docker
docker version
#curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
#chmod +x /usr/local/bin/docker-compose
echo ">>>>>>>>>>>>>>>>>>>>>>Start to configure Docker Compose using python pip>>>>>>"
apt-get install python-pip -y
yes | pip install docker-compose
docker-compose --version
apt-get install  libtool libltdl-dev -y
echo ">>>>>>>>>>>>>>>>>>>>>>>>>Start to download Bring Your First Network>>>>>>>>>>>"
git clone https://github.com/hyperledger/fabric-samples
cd $GOPATH/src
mkdir -p github.com/hyperledger
cd github.com/hyperledger
echo ">>>>>>>>>>>>>>>>>>>>>>>>>Start to download Fabric source code>>>>>>>>>>>>>>>>>"
git clone https://github.com/hyperledger/fabric.git
cd fabric
apt-get -y make
chmod -R 777 /usr/local/go/
chmod -R 777 /usr/local/go/blog/template/
chmod -R 777 /usr/local/go/pkg/linux_amd64/github.com/hyperledger/fabric/
make configtxgen
cd examples
cd e2e_cli
chmod +x download-dockerimages.sh
echo ">>>>>>>>>>>>>>>>>>>>>>>>>Start to download docker images>>>>>>>>>>>>>>>>>>>>>>"
./download-dockerimages.sh
chown -R ubuntu $GOPATH
cp -r  $GOPATH/src/github.com /usr/local/go/src/
cd /home/ubuntu
chown -R ubuntu fabric-samples
echo ">>>>>>>>>>>>>>>>>>>>>>>>>Start to download platform binaries>>>>>>>>>>>>>>>>>>>>>>"
cd /home/ubuntu/fabric-samples
echo ">>>>>>>>>>>>>>>>>>>>>>>>>Downloading platform binaries>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
#curl -sSL https://goo.gl/eYdRbX | bash
curl -sSL https://raw.githubusercontent.com/hyperledger/fabric/master/scripts/bootstrap-1.0.0.sh | bash

export VERSION=1.0.0
export ARCH=$(echo "$(uname -s|tr '[:upper:]' '[:lower:]'|sed 's/mingw64_nt.*/windows/')-$(uname -m | sed 's/x86_64/amd64/g')" | awk '{print tolower($0)}')
#Set MARCH variable i.e ppc64le,s390x,x86_64,i386
export MARCH=`uname -m`
#curl -sSL https://nexus.hyperledger.org/content/repositories/releases/org/hyperledger/fabric/hyperledger-fabric/${ARCH}-${VERSION}/hyperledger-fabric-${ARCH}-${VERSION}.tar.gz | tar xz

cp ./bin/* /usr/local/go/bin
echo ">>>>>>>>>>>>>>>>>>>>>>>>>install xfce and virtualbox additions>>>>>>>>>>>>>>>>>>>>>>"
apt-get install -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
apt-get install -y xserver-xorg-legacy
VBoxClient --clipboard
VBoxClient --draganddrop
VBoxClient --display
VBoxClient --checkhostversion
VBoxClient --seamless
# Permit anyone to start the GUI
sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config
#startx