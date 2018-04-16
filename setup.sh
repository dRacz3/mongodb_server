#creating data path
mkdir -p Shards
sudo chmod 777 -R /data
sudo mkdir -p /configdb
sudo mkdir -p Shards/datadb1
sudo mkdir -p Shards/datadb2
sudo mkdir -p Shards/datadb3


#creates a data directory to store the cluster metadata
mkdir dataconfigdb

#launches the config server deamon on port 27010. The default port 27019, but I have overriden by using the --port command line option.
mongod --configsvr --port 27010

#This is the routing service for the sharding cluster where by it takes queries from the application and gets the data from the specific shards. Query routers can be setup by using the mongos command as shown below:

mongos -configdb localhost:27010 --port 27011
#--configdb command line option is used to let the Query router know about the config servers we have setup. It takes a comma separated : values like –configdb host1:port1,host2:port2. In our case we have only 1 config server.

###Running mongodb shards

#Now we need to run the actual mongodb instances which store the shared data. We will created 3 sharded instances of mongodb and run all of these on localhost on different ports and provide each mongodb instance its own --dbpath as shown below:

#Mongodb Shard – 1
mongod --port 27012 --dbpath Shards/datadb1
#Mongodb Shard – 2
mongod --port 27013 --dbpath Shards/datadb2
#Mongodb Shard – 3
mongod --port 27014 --dbpath Shards/datadb3
