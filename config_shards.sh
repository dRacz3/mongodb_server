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
        {_id: 1, host: 'localhost:27020'},
        {_id: 2, host: 'localhost:27021'},
        {_id: 3, host: 'localhost:27022'},
        {_id: 4, host: 'localhost:27023'},
        {_id: 5, host: 'localhost:27024'}
    ]
}"
mongo localhost:27020 --eval "JSON.stringify(db.adminCommand({'replSetInitiate' : $cfgrs0}))"
echo "----------------------------------------"
echo "Setting up RS1 replica set"
cfgrs1="{
    _id: 'rs1',
    members: [
        {_id: 1, host: 'localhost:27030'},
        {_id: 2, host: 'localhost:27031'},
        {_id: 3, host: 'localhost:27032'}
        {_id: 4, host: 'localhost:27033'},
        {_id: 5, host: 'localhost:27034'}
    ]
}"
mongo localhost:27030 --eval "JSON.stringify(db.adminCommand({'replSetInitiate' : $cfgrs1}))"
echo "----------------------------------------"
echo "Setting up RS2 replica set"
cfgrs2="{
    _id: 'rs2',
    members: [
        {_id: 1, host: 'localhost:27040'},
        {_id: 2, host: 'localhost:27041'},
        {_id: 3, host: 'localhost:27042'}
        {_id: 4, host: 'localhost:27043'},
        {_id: 5, host: 'localhost:27044'}
    ]
}"
mongo localhost:27040 --eval "JSON.stringify(db.adminCommand({'replSetInitiate' : $cfgrs2}))"
