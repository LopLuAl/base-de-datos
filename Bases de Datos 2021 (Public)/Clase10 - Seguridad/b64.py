#!/usr/bin/env python
import base64

bstr = input("Ingrese caracteres raros:  ")

enc = base64.b64encode(bstr.encode('ascii'))
print("Codificado en base64: {}".format(enc))

dec = base64.b64decode(enc)
print("Decodficado de nuevo: {}".format(dec))
