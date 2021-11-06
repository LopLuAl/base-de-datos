from redlock import Redlock
from time import sleep
from random import randrange

lm = Redlock([{"host": "localhost", "port": 6379, "db": 0}, ])

def process(l):
  print(">> Ahora me toca a mi!")
  print(l)
  # Hago cualquier cosa que necesite exclusividad y tarde
  sleep(randrange(1000, 4000)/1000.0)
  print("Listo el pollo!")

if __name__ == '__main__':

  while(True):
    l = lm.lock("some-resource", 3000)

    if(l):
      process(l)
      lm.unlock(l)
    else:
      print(">> Espero un rato...")

    sleep(0.5)