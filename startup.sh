xterm -e mongod --configsvr --port 27010&
xterm -e mongos -configdb localhost:27010 --port 27011&

xterm -e mongod --port 27012 --dbpath data/datadb
xterm -e mongod --port 27013 --dbpath data/datadb2
xterm -e mongod --port 27014 --dbpath data/datadb3
