import redis
from threading import Thread, get_ident

## Atomic counter in Redis
KEY = "incr-this"
COUNT = 2000

def count():
  # Add one to counter
  r = redis.Redis()
  print("Thread: %i, Value: %i" % (get_ident(), r.incr(KEY)))

def reset():
  # Reset counter
  r = redis.Redis()
  r.delete(KEY)

def run():
  reset()
  for i in range(COUNT):
    Thread(target=count).start()

if __name__ == '__main__':
  run()
