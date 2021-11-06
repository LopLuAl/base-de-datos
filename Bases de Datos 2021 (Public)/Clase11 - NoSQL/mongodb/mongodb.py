#!/usr/bin/env python

from pymongo import Connection

# Optional: Connection(host, port);
conn = Connection();
db = conn.mydatabase;

# Funcion para imprimir separadores
def sep():
  print "-"*50

# All operations are "lazy". Nothing is performed until actually required.

if __name__ == "__main__":
  sep()
  print "Collections en la DB: ", db.collection_names()
  sep()
  
  # Leo un campo/valor cualquiera para todos los usuariso
  field, value = raw_input("Ingrese un nuevo campo,valor para los usuarios: ").split(",")
  coll = db.users;

  # Itero y guardo
  sep()
  for u in coll.find():
    print "Usuario [%s]: %s" % (u['_id'], u['username'])
    # Agrego un valor
    u[field] = value
    coll.save(u)

  sep()
  print "Guardado {%s: %s} para todos los usuarios" % (field, value)