mongo --port 27011 --host localhost
sh.addShard("localhost:27021")
sh.addShard("localhost:27022")
sh.addShard("localhost:27023")
