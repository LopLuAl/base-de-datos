#!/usr/bin/env python
from Crypto.Cipher import AES
from Crypto import Random


# 16 bytes es la longitud minima de la llave
KEY = 'a$3dcf1#4tTy78(!'

if __name__ == '__main__':
    # Llave, modo
    cipher = AES.new(KEY, AES.MODE_ECB)

    msg = input("Ingrese mensaje a encriptar: ")

    # La longitud del mensaje debe ser multiplo de 16 bytes, agrego espacios
    length = 16 * (int(len(msg) / 16) + 1)
    msg = msg.ljust(length)

    # Encripto el mensaje
    enc = cipher.encrypt(msg)

    print ("El mensaje encriptado es: %r" % (enc))

    # Desencripto el mensaje, y le saco los espacios
    decipher = AES.new(KEY, AES.MODE_ECB)
    print ("Y vuelto a desencriptar es:", decipher.decrypt(enc).lstrip())

    # >>> ciphertext = obj.encrypt(message)
    # >>> ciphertext
    # '\xd6\x83\x8dd!VT\x92\xaa`A\x05\xe0\x9b\x8b\xf1'
    # >>> obj2 = AES.new('This is a key123', AES.MODE_CBC, 'This is an IV456')
    # >>> obj2.decrypt(ciphertext)
    # 'The answer is no'
