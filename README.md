MongoDB version :  3.2

installation howto:
https://docs.mongodb.com/v3.2/installation/

replication:
https://docs.mongodb.com/v3.2/replication/

deploying a shard cluster
https://docs.mongodb.com/v3.2/tutorial/deploy-shard-cluster/

localhost sharding tutorial
https://sanaulla.info/2015/02/02/setting-up-sharded-mongodb-cluster-in-localhost/


# installation:

```console
$sudo ./install_mongo.sh
$./startup.sh
$./setup_shards.sh -> not working.. have to copy commands from line 2 till the end to the terminals rn.
```

# __Create db and import data into collection:__

**start mongo:**
```console
$mongo --port 27011 --host localhost
```
**create or load database:**
```console
$use cluster
```
**Create a collection if do not have any:**
```console
$db.createCollection("users")
```
**Import data set into collection**(from mongo shell won't work,  you have to use system shell):
1. import .json file:
```console
$mongoimport --host=localhost --port=27011  --db cluster --collection users --file data/database.json
```
2. import .csv file:
```console
$mongoimport --host=localhost --port=27011  --db cluster --collection users --type csv --headerline --file data/short_data.csv
```
where
host: server ip
port: server port
db: database name
collection: collection name
type: data file type
headerline: import headerline as well
file: data path


# __TODO: Move these to config JS files:__
https://stackoverflow.com/questions/4837673/how-to-execute-mongo-commands-through-shell-scripts

__configserver replication setup:__
```console
mongo --port 27010 --host localhost
rs.initiate({_id: "rsconf", version : 1, members : [{_id: 0, host : "localhost:27010"}]})
rs.add("localhost:27008")
rs.add("localhost:27009")
```


__Setting up an individual shard/replica set__
```console
mongo --port <port> --host <ip>
rs.initiate({_id: "<replica_set_name>", version : 1, members : [{_id: 0, host : "<ip>:<port>"}]})
rs.add("<ip_of_the_Secondary>:<port_of_the_Secondary>")
rs.add("<ip_of_the_other_Secondary>:<port_of_the_other_Secondary>")
```

__In our case the process is the following :__

*Shard0:*  
```console
mongo --port 27021 --host localhost
rs.initiate({_id: "rs0", version : 1, members : [{_id: 0, host : "localhost:27021"}]})
rs.add("localhost:27022")
rs.add("localhost:27023")
```
*Shard1:*  
```console
mongo --port 27025 --host localhost
rs.initiate({_id: "rs1", version : 1, members : [{_id: 0, host : "localhost:27025"}]})
rs.add("localhost:27026")
rs.add("localhost:27027")
```
*Shard2:*  
```console
mongo --port 27029 --host localhost
rs.initiate({_id: "rs2", version : 1, members : [{_id: 0, host : "localhost:27029"}]})
rs.add("localhost:27030")
rs.add("localhost:27031")
```

**Range sharding**
1. Enable sharding:
```console
sh.enableSharding("cluster")
```

2. Create indexing:
```console
db.users.createIndex({ age: 1 })
```

3. Sharding of the collection:
```console
sh.shardCollection("cluster.users", { "age": 1 } )
```

4. Decrease chunk size to 1Mb:
```console
db.settings.save( { _id:"chunksize", value: 1 } )
```

5. Add tags to the shards:
```console
sh.addShardTag("rs0", "under20")
sh.addShardTag("rs1", "btwn20and50")
sh.addShardTag("rs2", "over50")
```

6. Add ranges to the tags:
```console
sh.addTagRange( "cluster.users", { age: 20 }, { age: 50 }, "btwn20and50")
sh.addTagRange( "cluster.users", { age: 1 }, { age: 20 }, "under20")
sh.addTagRange( "cluster.users", { age: 50 }, { age: 100 }, "over50")
```

Check the results:
```console
sh.status()
db.printShardingStatus(true)
```
