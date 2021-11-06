#!/usr/bin/env python
from xmlrpc.client import ServerProxy
from pprint import pprint

server = ServerProxy('http://localhost:8000')

print(server.echo('hola'))
print(server.add(3, 5))

while(True):
    artist = input('artist?: ')
    pprint(server.get_artist_and_albums(artist))
