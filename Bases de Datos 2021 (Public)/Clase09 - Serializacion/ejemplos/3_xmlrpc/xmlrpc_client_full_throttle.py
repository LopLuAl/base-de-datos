#!/usr/bin/env python
from xmlrpc.client import ServerProxy
import random
import time
from threading import Thread


import model

artists = [a.name for a in model.Artist.select()]

URL = 'http://localhost:8000'
N_ARTISTS = 10
N_CLIENTS = 10


class ClientThread(Thread):
    def __init__(self, url):
        self.server = ServerProxy(url)
        Thread.__init__(self)

    def run(self):
        for n in range(N_ARTISTS):
            self.server.get_artist_and_albums(random.choice(artists))


# creo N_CLIENTS threads
clients = [ClientThread(URL) for n in range(N_CLIENTS)]

t0 = time.time()
# arranco los threads
for c in clients:
    c.start()
# espero a que terminen todos los threads
for c in clients:
    c.join()

print('{}\ntime: {}\n{}'.format('*' * 30, time.time() - t0, '*' * 30))
