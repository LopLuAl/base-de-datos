#!/usr/bin/env python
from flask import Flask, jsonify
from flask_restful import Resource, Api
import model

app = Flask(__name__)
api = Api(app)


@api.resource('/artists/')
class ArtistsList(Resource):
    def get(self):
        return jsonify([a.name for a in model.Artist.select()])


@api.resource('/artists/<name>')
class ArtistAndAlbums(Resource):
    def get(self, name):
        return jsonify(model.finder(name.replace('|', '/')))


if __name__ == '__main__':
    app.run(debug=True)
