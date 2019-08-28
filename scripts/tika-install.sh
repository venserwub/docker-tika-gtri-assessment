#!/bin/bash

#install tika dependencies
apt-get update -y
apt-get install -y default-jdk wget curl unzip

#install maven
export MVN_VER="3.6.1"
cd /tmp
wget http://www-eu.apache.org/dist/maven/maven-3/${MVN_VER}/binaries/apache-maven-${MVN_VER}-bin.tar.gz
tar xvf apache-maven-${MVN_VER}-bin.tar.gz
mv /tmp/apache-maven-${MVN_VER} /opt/maven

cat <<EOF | tee /etc/profile.d/maven.sh
export MAVEN_HOME=/opt/maven
export PATH=\$PATH:\$MAVEN_HOME/bin
EOF

source /etc/profile.d/maven.sh

#install tika
export TIKA_VER="1.22"
cd /tmp
wget https://archive.apache.org/dist/tika/tika-${TIKA_VER}-src.zip
unzip -q tika-${TIKA_VER}-src.zip
cd /tmp/tika-${TIKA_VER}
mvn install
