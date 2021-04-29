#! /bin/bash
mkdir /minecraft
mount /dev/sda2 /minecraft
yum install java
curl https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar ~
java -Xmx1024M -Xms1024M --nogui --universe /minecraft --world friends -jar ~/minecraft_server.1.16.5.jar