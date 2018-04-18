#creating data path
mkdir -p dataconfigdb
mkdir -p dataconfigdb/confdb1
mkdir -p dataconfigdb/confdb2
mkdir -p dataconfigdb/confdb3
mkdir -p Shards
mkdir -p Shards/datadb1
mkdir -p Shards/datadb2
mkdir -p Shards/datadb3


echo "Starting up mongo config server on port: 27010"
xterm -e mongod --configsvr --dbpath dataconfigdb/confdb1 --port 27008 --bind_ip 127.0.0.1 --replSet rs1&
xterm -e mongod --configsvr --dbpath dataconfigdb/confdb2 --port 27009 --bind_ip 127.0.0.1 --replSet rs1&
xterm -e mongod --configsvr --dbpath dataconfigdb/confdb3 --port 27010 --bind_ip 127.0.0.1 --replSet rs1&
echo "Starting up router on port : 27011"
xterm -e mongos -configdb rs1/localhost:27010 --port 27011 --bind_ip 127.0.0.1&


echo "Running shards: "
xterm -e mongod --shardsvr --port 27021 --bind_ip 127.0.0.1 --dbpath Shards/datadb1/ --replSet rs0&
xterm -e mongod --shardsvr --port 27022 --bind_ip 127.0.0.1 --dbpath Shards/datadb2/ --replSet rs0&
xterm -e mongod --shardsvr --port 27023 --bind_ip 127.0.0.1 --dbpath Shards/datadb3/ --replSet rs0&

echo "Running configserver: "


echo "Startup finshed, shards are probably running?!"
