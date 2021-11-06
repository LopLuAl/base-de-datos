#!/usr/bin/env python
from twisted.internet import reactor
from twisted.web import server
from twisted.web import xmlrpc
from twisted.internet import threads

# el modelo
import model


class XMLRPCserver(xmlrpc.XMLRPCIntrospection):
    def __init__(self):
        xmlrpc.XMLRPCIntrospection.__init__(self, self)

    def _getPeerAddress(self):
        return self.request.getClientAddress()

    def render(self, request):
        self.request = request
        return xmlrpc.XMLRPC.render(self, request)

    # #########################################################
    # get_artist_and_albums
    # #########################################################
    def xmlrpc_get_artist_and_albums(self, artist):
        """
            devuelve los datos de un artista y
            todos sus albums
        """
        print("get_artist_and_albums <%s> desde %s" % (artist, self._getPeerAddress()))
        d = threads.deferToThread(model.finder, artist)
        d.addCallback(lambda result: result)
        d.addErrback(lambda failure: failure.getErrorMessage())
        return d
    xmlrpc_get_artist_and_albums.signature = [['list', 'str']]

    # #########################################################
    # echo
    # #########################################################
    def xmlrpc_echo(self, s):
        """
            devuelve lo mismo que recibe
        """
        print("echo <%s> desde %s" % (s, self._getPeerAddress()))
        return s
    xmlrpc_echo.signature = [['whatever_you_send', 'whatever']]

    # #########################################################
    # add
    # #########################################################
    def xmlrpc_add(self, a, b):
        """
            suma dos numeros o concatena dos strings
        """
        print("add <%s>%s + <%s>%s desde %s" % (str(a), type(a),
                                                str(b), type(b),
                                                self._getPeerAddress()))
        return a + b
    xmlrpc_add.signature = [['str', 'str', 'str'],
                            ['int', 'int', 'int'],
                            ['float', 'float', 'float'],
                            ]


if __name__ == '__main__':
    reactor.listenTCP(8000,
                      server.Site(XMLRPCserver()),
                      )
    reactor.run()
