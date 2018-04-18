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
$use ourdb
```
**Create a collection if do not have any:**
```console
$db.createCollection("Users")
```
**Import data set into collection**(from mongo shell won't work,  you have to use system shell):
1. import .json file:
```console
$mongoimport --host=localhost --port=27011  --db ourdb --collection Users --file data/database.json
```
2. import .csv file:
```console
$mongoimport --host=localhost --port=27011  --db ourdb --collection Users --type csv --headerline --file data/short_data.csv
```
where
host: server ip
port: server port
db: database name
collection: collection name
type: data file type
headerline: import headerline as well
file: data path




