import redis
import pprint
from sys import argv

CHANNEL = 'stock:%s'

pp = pprint.PrettyPrinter(indent=4)

if __name__ == '__main__':
  # Obtengo la instancia de "Publisher's subscriber"
  pubsub = redis.Redis().pubsub()

  # Los canales se pasan por linea de comandos (todos menos el programa)
  # Puedo suscribirme a uno o varios canales
  channels = [CHANNEL % (i) for i in argv[1:]]
  pubsub.subscribe(channels)
  print("Subscripto los canales: ", channels)

  # Listen es bloqueante. Se queda esperando el siguiente mensaje
  for msg in pubsub.listen():
    # Hago mi proceso cuando recibo un mensaje.
    print("---")
    pp.pprint(msg)
    if(msg["type"] == "message"):
      print(">> El precio del %s es %.2f" % (msg['channel'].split(":".encode("utf-8"))[1], float(msg['data'])))