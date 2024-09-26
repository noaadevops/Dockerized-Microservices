#!/bin/bash

    apt-get update
    apt-get upgrade -y
 
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    apt-get update
    apt-get install -y openjdk-8-jre
    apt-get install -y jenkins