#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sqlobject as so
import os
import paho.mqtt.client as mqtt
import json


class Serializer:
    def serialize(self):
        d = dict((c, getattr(self, c)) for c in self.sqlmeta.columns)
        d['id'] = self.id
        d['class'] = self.__class__.__name__
        return d

    def notify(self, broker, action):
        d = self.serialize()
        d['action'] = action
        broker.publish(topic='TEST', payload=json.dumps(d), qos=2)


class Artist(so.SQLObject, Serializer):
    name = so.StringCol(length=120, varchar=True)


class Album(so.SQLObject, Serializer):
    title = so.StringCol(length=160, varchar=True)
    artist = so.ForeignKey('Artist', default=None)


if __name__ == '__main__':
    # connection = so.connectionForURI("sqlite://" + os.getcwd() + "/broker_orm.sqlite")
    connection = so.connectionForURI("sqlite:/:memory:")
    so.sqlhub.processConnection = connection
    broker = mqtt.Client()
    broker.connect('localhost')
    broker.loop_start()

    # borro las tablas si ya existian
    Artist.dropTable(ifExists=True)
    Album.dropTable(ifExists=True)

    # creo las tablas
    Artist.createTable()
    Album.createTable()

    # lleno Artist con los artistas levantados de 'artist.txt'
    for n in open('artist.txt').readlines():
        name = n.rstrip('\n')
        print("... cargando artista '{}'".format(name))
        a = Artist(name=name)
        a.notify(broker, 'insert')

    # lleno Album con los albums levantados de 'album.csv'
    import csv
    reader = csv.DictReader(open('album.csv'), delimiter=',', quotechar='"')
    for row in reader:
        artist = Artist.selectBy(name=row['Name']).getOne()
        print("... cargando album '{}' del artista '{}'".format(row['Title'], row['Name']))
        album = Album(title=row['Title'], artist=artist)
        album.notify(broker, 'insert')

    broker.disconnect()
