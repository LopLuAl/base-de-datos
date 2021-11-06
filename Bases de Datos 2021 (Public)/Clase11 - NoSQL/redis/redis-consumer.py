#!/usr/bin/env python

import redis
from sys import argv

# Defaults: 'localhost', 6379, db=0
db = redis.Redis()

QUEUE = 'messages'

if __name__ == '__main__':
  count = (db.llen(QUEUE))
  if count:
    print("Hay %d mensajes en cola" % count)
    print("Recibiendo: ", db.lpop(QUEUE))
  else:
    print("No hay mensajes en cola")