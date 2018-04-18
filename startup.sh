echo "Creating folders for config server!"
mkdir -p dataconfigdb dataconfigdb/confdb1 dataconfigdb/confdb2 dataconfigdb/confdb3

echo "Create folders for each shard!"
mkdir -p shard1 shard1/db1 shard1/db2 shard1/db3 shard1/arbiter
mkdir -p shard2 shard2/db1 shard2/db2 shard2/db3 shard2/arbiter
mkdir -p shard3 shard3/db1 shard3/db2 shard3/db3 shard3/arbiter

echo "Starting up mongo config server on port: 27010"
xterm -e mongod --configsvr --dbpath dataconfigdb/confdb1 --port 27008 --bind_ip 127.0.0.1 --replSet rs_conf&
xterm -e mongod --configsvr --dbpath dataconfigdb/confdb2 --port 27009 --bind_ip 127.0.0.1 --replSet rs_conf&
xterm -e mongod --configsvr --dbpath dataconfigdb/confdb3 --port 27010 --bind_ip 127.0.0.1 --replSet rs_conf&
echo "Starting up router on port : 27011"
xterm -e mongos -configdb rs_conf/localhost:27010 --port 27011 --bind_ip 127.0.0.1&


echo "Running shard 0 : "
xterm -e mongod --shardsvr --port 27021 --bind_ip 127.0.0.1 --dbpath shard1/db1/ --replSet rs0&
xterm -e mongod --shardsvr --port 27022 --bind_ip 127.0.0.1 --dbpath shard1/db2/ --replSet rs0&
xterm -e mongod --shardsvr --port 27023 --bind_ip 127.0.0.1 --dbpath shard1/db3/ --replSet rs0&

echo "Running shard 1 : "
xterm -e mongod --shardsvr --port 27025 --bind_ip 127.0.0.1 --dbpath shard2/db1/ --replSet rs1&
xterm -e mongod --shardsvr --port 27026 --bind_ip 127.0.0.1 --dbpath shard2/db2/ --replSet rs1&
xterm -e mongod --shardsvr --port 27027 --bind_ip 127.0.0.1 --dbpath shard2/db3/ --replSet rs1&

echo "Running shard 2 : "
xterm -e mongod --shardsvr --port 27029 --bind_ip 127.0.0.1 --dbpath shard2/db1/ --replSet rs2&
xterm -e mongod --shardsvr --port 27030 --bind_ip 127.0.0.1 --dbpath shard2/db2/ --replSet rs2&
xterm -e mongod --shardsvr --port 27031 --bind_ip 127.0.0.1 --dbpath shard2/db3/ --replSet rs2&

echo "Startup finshed!"
