echo "Setting up replica sets!"
echo "----------------------------------------"
echo "Setting up configuration replica set"
cfg="{
    _id: 'rsconf',
    members: [
        {_id: 1, host: 'localhost:27010'},
        {_id: 2, host: 'localhost:27009'},
        {_id: 3, host: 'localhost:27008'}
    ]
}"
mongo localhost:27010 --eval "JSON.stringify(db.adminCommand({'replSetInitiate' : $cfg}))"
echo "----------------------------------------"
echo "Setting up RS0 replica set"
cfgrs0="{
    _id: 'rs0',
    members: [
        {_id: 1, host: 'localhost:27021'},
        {_id: 2, host: 'localhost:27022'},
        {_id: 3, host: 'localhost:27023'}
    ]
}"
mongo localhost:27021 --eval "JSON.stringify(db.adminCommand({'replSetInitiate' : $cfgrs0}))"
echo "----------------------------------------"
echo "Setting up RS1 replica set"
cfgrs1="{
    _id: 'rs1',
    members: [
        {_id: 1, host: 'localhost:27025'},
        {_id: 2, host: 'localhost:27026'},
        {_id: 3, host: 'localhost:27027'}
    ]
}"
mongo localhost:27025 --eval "JSON.stringify(db.adminCommand({'replSetInitiate' : $cfgrs1}))"
echo "----------------------------------------"
echo "Setting up RS2 replica set"
cfgrs2="{
    _id: 'rs2',
    members: [
        {_id: 1, host: 'localhost:27029'},
        {_id: 2, host: 'localhost:27030'},
        {_id: 3, host: 'localhost:27031'}
    ]
}"
mongo localhost:27029 --eval "JSON.stringify(db.adminCommand({'replSetInitiate' : $cfgrs2}))"
