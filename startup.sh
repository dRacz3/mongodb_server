echo "Creating folders for config server!"
CONF_FOLDER="dataconfigdb"
CONF_SUBFOLDER="confdb"
mkdir -p $CONF_FOLDER $CONF_FOLDER/$CONF_SUBFOLDER"0" $CONF_FOLDER/$CONF_SUBFOLDER"1" $CONF_FOLDER/$CONF_SUBFOLDER"2"

echo "Create folders for each shard!"
SHARD_FOLDER="shard"
SHARD_SUBFOLDER="db"
for i in 0 1 2
do
  mkdir -p $SHARD_FOLDER$i
  for j in 0 1 2
  do
    mkdir -p $SHARD_FOLDER$i/$SHARD_SUBFOLDER$j
  done
  mkdir -p $SHARD_FOLDER$i/"arbiter"
done


pkill mongod
pkill mongos

echo "Starting up mongo config server on port: 27010"
# call rs.initiate({...})
xterm -e mongod --configsvr --dbpath $CONF_FOLDER/$CONF_SUBFOLDER"0"/ --port 27008 --bind_ip 127.0.0.1 --replSet rsconf&
xterm -e mongod --configsvr --dbpath $CONF_FOLDER/$CONF_SUBFOLDER"1"/ --port 27009 --bind_ip 127.0.0.1 --replSet rsconf&
xterm -e mongod --configsvr --dbpath $CONF_FOLDER/$CONF_SUBFOLDER"2"/ --port 27010 --bind_ip 127.0.0.1 --replSet rsconf&


echo "Starting up router on port : 27011"
xterm -e mongos -configdb rsconf/localhost:27010 --port 27011 --bind_ip 127.0.0.1&

echo "Running shard 0 : "
SHARD_ID="0"
xterm -e mongod --shardsvr --port 27021 --bind_ip 127.0.0.1 --dbpath $SHARD_FOLDER$SHARD_ID/$SHARD_SUBFOLDER"0"/ --replSet rs0&
xterm -e mongod --shardsvr --port 27022 --bind_ip 127.0.0.1 --dbpath $SHARD_FOLDER$SHARD_ID/$SHARD_SUBFOLDER"1"/ --replSet rs0&
xterm -e mongod --shardsvr --port 27023 --bind_ip 127.0.0.1 --dbpath $SHARD_FOLDER$SHARD_ID/$SHARD_SUBFOLDER"2"/ --replSet rs0&

echo "Running shard 1 : "
SHARD_ID="1"
xterm -e mongod --shardsvr --port 27025 --bind_ip 127.0.0.1 --dbpath $SHARD_FOLDER$SHARD_ID/$SHARD_SUBFOLDER"0"/ --replSet rs1&
xterm -e mongod --shardsvr --port 27026 --bind_ip 127.0.0.1 --dbpath $SHARD_FOLDER$SHARD_ID/$SHARD_SUBFOLDER"1"/ --replSet rs1&
xterm -e mongod --shardsvr --port 27027 --bind_ip 127.0.0.1 --dbpath $SHARD_FOLDER$SHARD_ID/$SHARD_SUBFOLDER"2"/ --replSet rs1&

echo "Running shard 2 : "
SHARD_ID="2"
xterm -e mongod --shardsvr --port 27029 --bind_ip 127.0.0.1 --dbpath $SHARD_FOLDER$SHARD_ID/$SHARD_SUBFOLDER"0"/ --replSet rs2&
xterm -e mongod --shardsvr --port 27030 --bind_ip 127.0.0.1 --dbpath $SHARD_FOLDER$SHARD_ID/$SHARD_SUBFOLDER"1"/ --replSet rs2&
xterm -e mongod --shardsvr --port 27031 --bind_ip 127.0.0.1 --dbpath $SHARD_FOLDER$SHARD_ID/$SHARD_SUBFOLDER"2"/ --replSet rs2&

echo "Startup finshed!"

sleep 10

./config_shards.sh
