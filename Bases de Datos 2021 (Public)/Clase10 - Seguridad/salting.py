#!/usr/bin/env python

import bcrypt

password = input("Ingrese un password: ")
password = password.encode('utf-8')

# Hash+Salt tres veces, para mostrar que siempre son distintos.
print ("." * 40)
print ("El password '{}', hashed+salted tres veces:".format(password))
hash1 = bcrypt.hashpw(password, bcrypt.gensalt())
hash2 = bcrypt.hashpw(password, bcrypt.gensalt())
hash3 = bcrypt.hashpw(password, bcrypt.gensalt())
print ("%s\n%s\n%s" % (hash1, hash2, hash3))
print ("." * 40)

# Verificar el password
verify = input("Ingrese el password nuevamente: ")
verify = verify.encode('utf-8')

# Verifico contra los hashes generados previamente
print ("." * 40)
# Hash1
if bcrypt.hashpw(verify, hash1) == hash1:
    print ("Password {} verifica con {}".format(verify, hash1))
else:
    print ("{} ** NO ** verifica contra {}".format(verify, hash1))

# Hash2
if bcrypt.hashpw(verify, hash2) == hash2:
    print ("Password {} verifica con {}".format(verify, hash2))
else:
    print ("{} ** NO ** verifica contra {}".format(verify, hash2))

# Hash3
if bcrypt.hashpw(verify, hash3) == hash3:
    print ("Password {} verifica con {}".format(verify, hash3))
else:
    print ("{} ** NO ** verifica contra {}".format(verify, hash3))
