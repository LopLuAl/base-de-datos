#!/usr/bin/env python
import sqlobject as so
import os

connection = so.connectionForURI("sqlite://" + os.getcwd() + "/albums.sqlite")
so.sqlhub.processConnection = connection


class Artist(so.SQLObject):
    name = so.StringCol(length=120, varchar=True)


class Album(so.SQLObject):
    title = so.StringCol(length=160, varchar=True)
    artist = so.ForeignKey('Artist', default=None)


def to_dict(obj):
    d = dict((c, getattr(obj, c)) for c in obj.sqlmeta.columns)
    d['id'] = obj.id
    return d


def finder(name):
    artist = Artist.selectBy(name=name).getOne()
    albums = Album.select(Album.q.artist == artist)
    d = to_dict(artist)
    d['albums'] = [to_dict(album) for album in albums]
    return d
