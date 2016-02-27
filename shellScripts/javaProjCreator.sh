#!/bin/bash

echo -e "Enter the favorable path for project generation"
read dirPath
cd "$dirPath"
echo -e "Enter project name > \n"
read projName
mkdir $projName
cd $projName
mkdir src
cd src
mkdir main
mkdir test
cd main
mkdir java
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


