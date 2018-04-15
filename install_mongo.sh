# This script will install the 3.2.19 version from the official mongoDB mirror
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.com/apt/ubuntu xenial/mongodb-enterprise/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-enterprise.list
sudo apt-get update
sudo apt-get install -y mongodb-enterprise
sudo apt-get install -y mongodb-enterprise=3.2.19 mongodb-enterprise-server=3.2.19 mongodb-enterprise-shell=3.2.19 mongodb-enterprise-mongos=3.2.19 mongodb-enterprise-tools=3.2.19


mkdir mongoDB_Project
cd mongoDB_Project


#creating data path
mkdir data
sudo chmod 777 -r data 
sudo mkdir -p /data/configdb
sudo mkdir -p /data/datadb
sudo mkdir -p /data/datadb2
sudo mkdir -p /data/datadb3

