#!/bin/bash

redis-cli

# Redis es un key-value store. 
# Es muy rapido (todo sucede en memoria) y particionable
# Solamente soporta strings, hashes, listas, sets y sets ordenados
# *** Garantiza que todas las operaciones son atomicas ***
# Corre por default en el puerto 6379

# Selecciona una DB. En redis son numeradas
# El maximo por default es 16, configurable.
select 0


# Numeros o strings
set visits:counter 0
incr visits:counter
incr visits:counter
get visits:counter

set page:title "My Awesome Dragon Ball Website"
get page:title

# Hashes
hset goku power 9000
hget goku power 9000

# Lists
LPUSH letras "a"
RPUSH letras "b"
RPUSH letras "c"
LPOP letras

# Sets, sorted sets



