echo '######################################'
echo '###AVRO AWS JAR REPLACEMENT UTILITY###'
echo '######################################'


serverinstallationpath="/opt/avro/current"
serverlibspath="/opt/avro/current/lib"

mkdir -p $serverinstallationpath/copiedjars
mkdir -p $serverinstallationpath/jarbkp

#Backing up existing jar
echo "Backing up existing jar in the instance to folder $serverinstallationpath/copiedjars"

for entry in $serverlibspath/*
do
	originaljarfull=$entry
done

originaljar=$(basename $originaljarfull)

echo "Backing up existing jar:"
mv $serverlibspath/$originaljar $serverinstallationpath/jarbkp/

#CODE : SELECT AND COPY JAR FROM S3 LOCATION
echo 'Enter arguments for the utility to start JAR replacement. Note: I am not running validations on your arguments so please bear with me with correct arguments #put single quotes here'
read -p "Enter build number (eg:dev-b4946) :" buildnos
echo "Available jars for your build ::"
aws s3 ls s3://s3-as-dev-us-west-2-avro-01/repo/releases/$buildnos/ | awk '{print $NF}'  
read -p "Copy the jar name from the above list to be copied to current instance:"  newjar
echo "Parameters that you have entered...."
echo "buildnumber :" $buildnos
echo "jar to be copied :" $newjar

aws s3 cp s3://s3-as-dev-us-west-2-avro-01/repo/releases/$buildnos/$newjar $serverinstallationpath/copiedjars/

echo "Renaming Jars:"
cp $serverinstallationpath/copiedjars/$newjar  $serverlibspath/
mv $serverlibspath/$newjar $serverlibspath/$originaljar

echo "Changing group and permission..."
chown avro $serverlibspath/$originaljar
chgrp avro $serverlibspath/$originaljar
chmod 740 $serverlibspath/$originaljar

echo "I am done, you can restart your engines!! (sample commands: sudo sytemctl avro-interfaces restart, to check engine health: sudo systemctl avro-interfaces satus)"


