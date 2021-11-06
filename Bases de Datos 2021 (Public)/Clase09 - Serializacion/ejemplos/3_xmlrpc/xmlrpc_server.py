#!/usr/bin/env python
from xmlrpc.server import SimpleXMLRPCServer

# el modelo
import model


# Crea el server
server = SimpleXMLRPCServer(("", 8000))
server.register_introspection_functions()


# Registra las funciones
# 1)
def get_artist_and_albums(artist):
    """
        devuelve los datos de un artista y
        todos sus albums
    """
    return model.finder(artist)


server.register_function(get_artist_and_albums, 'get_artist_and_albums')


# 2)
def echo(s):
    """
        devuelve lo mismo que recibe
    """
    return s


server.register_function(echo, 'echo')


# 3)
def adder(a, b):
    """
        suma dos numeros o concatena dos strings
    """
    return a + b


server.register_function(adder, 'add')


# Run the server's main loop
server.serve_forever()
