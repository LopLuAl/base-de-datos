import redis
from sys import argv

## Redis Publisher example

## Channel pattern
CHANNEL = 'stock:%s'

if __name__ == '__main__':
  r = redis.Redis()
  channel = CHANNEL % (argv[1])
  value = float(argv[2])
  print(">> Publicando en el canal %s : %f" % (channel, value))

  # Publico un valor en el canal.
  r.publish(channel, value)