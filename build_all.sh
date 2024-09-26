#!/bin/bash

cd shopfront
mvn clean install -DskipTests=true
cd ..
cd productcatalogue
mvn clean install -DskipTests=true
cd ..
cd stockmanager
mvn clean install -DskipTests=true
cd ..

