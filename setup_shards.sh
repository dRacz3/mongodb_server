mongo --port 27011 --host localhost
sh.addShard("rs0/localhost:27020")
sh.addShard("rs1/localhost:27030")
sh.addShard("rs2/localhost:27040")
