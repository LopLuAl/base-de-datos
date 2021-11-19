#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import MySQLdb
from utils.parchivos import lee_datos
import defs


def conectar(self):
    '''
        realiza la conexion a la base de datos
        retorna True si la conexion fue exitosa
    '''
    try:
        self._conn = MySQLdb.connect(host=self._host,
                                     user=self._user,
                                     passwd=self._passwd,
                                     db=self._dbase)
        self._conn.autocommit(True)
        return True
    except:
        print(sys.exc_info()[1])
        return False

def _verifica_conexion(self):
    '''
        verifica que se haya realizado una conexion a la base de datos
        retorna True si ya se realizo la conexion
    '''
    if not self._conn:
        print("Error. Todavia no se ha conectado a la base de datos %s" % self._dbase)
        return False
    return True

def listar(self):
    '''
        lista la tabla Artist
        retorna True si pudo realizar la operacion exitosamente
    '''
    if not self._verifica_conexion():
        return False
    error = False
    try:
        cur = self._conn.cursor()
        cur.execute("SELECT * FROM Artist ORDER BY ArtistId ASC")
        for id, name in cur.fetchall():
            print("%d\t%s" % (id, name))
    except:
        print(sys.exc_info()[1])
        error = True
    finally:
        cur.close()
    return error
