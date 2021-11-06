#!/usr/bin/env python

import redis
from sys import argv

# Defaults: 'localhost', 6379, db=0
db = redis.Redis()

QUEUE = 'messages'

if __name__ == '__main__':
  print("Encolando mensaje: ", argv[1])
  db.rpush(QUEUE, argv[1])
