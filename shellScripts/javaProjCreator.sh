#!/bin/bash

echo -e "Enter the favorable path for project generation"
read dirPath
cd "$dirPath"
echo -e "Enter project name > \n"
read projName
mkdir $projName
cd $projName
touch build.gradle
touch settings.gradle
mkdir src
cd src
mkdir java
mkdir test
cd java
echo -e "Enter desired package name : seperated by . \n"
read packname
IFS='.' read -ra packs <<< "$packname"
for fldrName in "${packs[@]}"
do	
	mkdir $fldrName
	cd $fldrName
done
touch main.java
echo "Your java project struture is ready for use"
$SHELL


