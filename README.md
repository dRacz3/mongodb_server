mongodb_server

user: mongolin
pw: q


MongoDB version :  3.2

installation howto: 
https://docs.mongodb.com/v3.2/installation/

replication:
https://docs.mongodb.com/v3.2/replication/

deploying a shard cluster
https://docs.mongodb.com/v3.2/tutorial/deploy-shard-cluster/

localhost sharding tutorial
https://sanaulla.info/2015/02/02/setting-up-sharded-mongodb-cluster-in-localhost/

__installation:__
$sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
$echo "deb http://repo.mongodb.com/apt/ubuntu xenial/mongodb-enterprise/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-enterprise.list
$sudo apt-get update
$sudo apt-get install -y mongodb-enterprise
$sudo apt-get install -y mongodb-enterprise=3.2.19 mongodb-enterprise-server=3.2.19 mongodb-enterprise-shell=3.2.19 mongodb-enterprise-mongos=3.2.19 mongodb-enterprise-tools=3.2.19
