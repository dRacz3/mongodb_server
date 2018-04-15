echo "Starting up mongo config server on port: 27010"
xterm -e mongod --configsvr --dbpath dataconfigdb/ --port 27010
echo "Starting up router on port : 27011"
sudo xterm -e mongos -configdb localhost:27010 --port 27011&


echo "Running shards: "
sudo mongod --port 27012 --dbpath data/datadb
sudo mongod --port 27013 --dbpath data/datadb2
sudo mongod --port 27014 --dbpath data/datadb3
echo "startup finshed!" 
