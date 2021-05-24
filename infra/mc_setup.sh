#! /bin/bash
mkdir /minecraft
mount /dev/sda2 /minecraft
yum -y install java
# curl https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar --output ~/server.jar
cd /minecraft/start
java -Xmx1024M -Xms1024M -jar ./server.jar --nogui --universe /minecraft --world friends 1>>./logs.txt