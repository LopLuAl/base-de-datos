#!/bin/bash

### MongoDB sharding example

# Create sharded databases
mkdir data1 data2 data3 data4 data5

# Create configuration database
mkdir configdb1 configdb2 configdb3

# Run databases
mongod --dbpath ./data1 --port 27001
mongod --dbpath ./data2 --port 27002
mongod --dbpath ./data3 --port 27003
mongod --dbpath ./data4 --port 27004
mongod --dbpath ./data5 --port 27005

# Run configuration databases
mongod --configsvr --dbpath ./configdb1 --port 27021
mongod --configsvr --dbpath ./configdb2 --port 27022
mongod --configsvr --dbpath ./configdb3 --port 27023

# Run mongos
mongos --port 27031 --configdb localhost:27021
mongos --port 27032 --configdb localhost:27021
mongos --port 27033 --configdb localhost:27021

# Connect to one mongos
mongo localhost:27031

# Add shards to the mongos, it'll propagate
> sh.addShard('localhost:27001');
> sh.addShard('localhost:27002');
> sh.addShard('localhost:27003');
> sh.addShard('localhost:27004');
> sh.addShard('localhost:27005');