#creating data path
mkdir -p dataconfigdb
mkdir -p Shards
mkdir -p Shards/datadb1
mkdir -p Shards/datadb2
mkdir -p Shards/datadb3


echo "Starting up mongo config server on port: 27010"
xterm -e mongod --configsvr --dbpath dataconfigdb/ --port 27010&
echo "Starting up router on port : 27011"
xterm -e mongos -configdb localhost:27010 --port 27011&


echo "Running shards: "
xterm -e mongod --port 27021 --dbpath Shards/datadb1/&
xterm -e mongod --port 27022 --dbpath Shards/datadb2/&
xterm -e mongod --port 27023 --dbpath Shards/datadb3/&
echo "Startup finshed, shards are probably running?!"
