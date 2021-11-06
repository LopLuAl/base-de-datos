#!/usr/bin/env python
# -*- coding: utf-8 -*-
from sqlobject import *

# declaro la conexion asi -> "mysql://user:password@host/database"
# __connection__ = connectionForURI("mysql://guest:guest@localhost/ormtest")
# __connection__.query("SET default_storage_engine = MyISAM")
# __connection__.debug = True
__connection__ = connectionForURI("sqlite:/:memory:")

class Artist(SQLObject):
    name = StringCol(length=120, varchar=True)

    def _set_name(self, value):
        self._SO_set_name(value.lower())

    def _get_name(self):
        return self._SO_get_name().upper()


if __name__ == '__main__':
    # borro la tabla si ya existia
    Artist.dropTable(ifExists=True)

    # creo la tabla
    Artist.createTable()

    # la lleno con los artistas levantados de 'artist.txt'
    for n in open('artist.txt').readlines():
        Artist(name=n.rstrip('\n'))

    n = input("busco por name usando selectBy(): ")
    for a in Artist.selectBy(name=n):
        print(a)
    input('\n...')

    n = input("busco por name que comience con...: ")
    for a in Artist.select(Artist.q.name.startswith(n)):
        print("id={}\t=> name={}".format(a.id, a.name))
