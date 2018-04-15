echo "Starting up mongo config server on port: 27010"
xterm -e mongod --configsvr --dbpath dataconfigdb/ --port 27010&
echo "Starting up router on port : 27011"
sudo xterm -e mongos -configdb localhost:27010 --port 27011&


echo "Running shards: "
sudo xterm -e mongod --port 27021 --dbpath shards/datadb1/&
sudo xterm -e mongod --port 27022 --dbpath shards/datadb2/&
sudo xterm -e mongod --port 27023 --dbpath shards/datadb3/&
echo "Startup finshed, shards are probably running?!" 
