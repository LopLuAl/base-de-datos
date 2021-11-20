#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import MySQLdb



class ABM_rebasico:
    '''
        implementa un ABM sencillo para la tabla Artist de Chinook
    '''
    def __init__(self, host, user, passwd, dbase):
        self._host = host
        self._user = user
        self._passwd = passwd
        self._dbase = dbase
        self._conn = None

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

    def listar_puertas(self):
        '''
            lista la tabla Artist
            retorna True si pudo realizar la operacion exitosamente
        '''
        if not self._verifica_conexion():
            return False
        error = False
        try:
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM Puerta ORDER BY ID ASC " )
            #SELECT * FROM Artist ORDER BY ArtistId ASC
            print("id\tAbierta/Cerrada")
            for id, name in cur.fetchall():
                print("%d\t%s" % (id, name))

        except:
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error
    def listar_personas(self):
        if not self._verifica_conexion():
            return False
        error = False
        try:
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM Persona ORDER BY ID ASC " )
            print("id\tNombre\tApellido\tEstado")
            for id, nombre,Apellido,Estado in cur.fetchall():
                print("%d\t%s\t%s\t%d" % (id, nombre,Apellido,Estado))

        except:
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error
    def agregar(self, datos):
        '''
            agrega nuevos 'artists' en la tabla Artist
            el listado de los artists a insertar viene en 'datos'
            retorna True si la operacion fue exitosa
        '''
        if not self._verifica_conexion():
            return False
        error = False
        try:
            cur = self._conn.cursor()
            for artist, otro in datos:
                print("... insertando '%s' en la tabla Artist" % artist)
                cur.execute("INSERT INTO Artist (Name) VALUES (%s)", (artist,))
        except:
            import traceback
            traceback.print_exc()
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error

    def borrar(self, datos):
        '''
            elimina 'artists' en la tabla Artist
            el listado de los artists a eliminar viene en 'datos'
            retorna True si la operacion fue exitosa
        '''
        if not self._verifica_conexion():
            return False
        error = False
        try:
            cur = self._conn.cursor()
            for artist, otro in datos:
                print("... borrando '%s' en la tabla Artist" % artist)
                cur.execute("DELETE FROM Artist WHERE Name=%s", (artist,))
        except:
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error

    def modificar(self, datos):
        '''
            modifica 'artists' en la tabla Artist
            el listado de los artists a modificar viene en 'datos'
            retorna True si la operacion fue exitosa
        '''
        if not self._verifica_conexion():
            return False
        error = False
        try:
            cur = self._conn.cursor()
            for artist, new_artist in datos:
                print("... modificando '%s' en la tabla Artist por '%s'" % (artist, new_artist))
                cur.execute("UPDATE Artist SET Name=%s WHERE Name=%s", (new_artist, artist))
        except:
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error

    def limpiar(self, datos):
        '''
            elimina 'artists' en la tabla Artist que hayan sido insertados o modificados
            el listado de los artists a eliminar viene en 'datos'
            retorna True si la operacion fue exitosa
        '''
        if not self._verifica_conexion():
            return False
        error = False
        try:
            cur = self._conn.cursor()
            for artist, otro in datos:
                print("... borrando '%s' y/o '%s' en la tabla Artist" % (artist, otro))
                cur.execute("DELETE FROM Artist WHERE Name=%s OR Name=%s", (artist, otro))
        except:
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error

    def chequear_tag(self,tag):
        if not self._verifica_conexion():
            return False
        error = False
        try:
            cur = self._conn.cursor()
            cur.execute("SELECT Nivel_acceso_persona.ID_pERSONA FROM Nivel_acceso_persona WHERE TAG_ID =" + "'" + str(tag)+"'" )
            lista = cur.fetchall()
            if lista:
                for id in lista:
                    print("ID de usuario que se va a conectar: %d\t" % (id))
                    id_usuario = id
                return id_usuario
            else:
                print("TAG ID NO ENCONTRADO")
                return -1
            '''
                con id_usuario me voy a mover en toda la base de datos para chequear
                A) Si el horario de entrada es el correcto
            .    B) Si el usuario esta activo
                C) Si el usuario quiere entrar a un nivel Permitido
            .    D) Identificarlo por nombre y apellido
                ->E) Chequeo tag
            '''
        except:
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error
    def identificar(self,id):
        if not self._verifica_conexion():
            return False
        error = False
        try:
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM Persona  WHERE ID =" + "'" + str(id)+"'" )
            lista = cur.fetchall()
            for ID,Nombre,Apellido,Estado in lista :
                print("Bienvenido %s, %s" % (Nombre, Apellido))
            if lista[0][3] == 1:
                print('Usuario Activo')
                return True
            else:
                print('Usuario dado de baja')
                return False
            '''
                con id_usuario me voy a mover en toda la base de datos para chequear
                A) Si el horario de entrada es el correcto
                .B) Si el usuario esta activo
                C) Si el usuario quiere entrar a un nivel Permitido
                .D) Identificarlo por nombre y apellido
                .E) Chequeo tag
            '''
        except:
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error
    def verificar_nivel(self,id,id_puerta):
        if not self._verifica_conexion():
            return False
        error = False
        try:
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM Nivel_acceso_persona  WHERE ID_Persona =" + "'" + str(id)+"'" )
            lista = cur.fetchall()
            ID_NIVEL_ACCESO             =   lista[0][1]
            NIVEL_ACCESO_PERSONA_MAXIMO =   lista[0][2]
            cur.execute("SELECT NIVEL_ACCESO FROM Nivel_acceso  WHERE ID =" + "'" + str(id_puerta)+"'" )
            lista = cur.fetchall()
            NIVEL_ACCESO                =   lista[0][0]
            print("ID_NIVEL_ACCESO %d, NIVEL_ACCESO_PERSONA_MAXIMO %d, NIVEL_ACCESO %d" %(ID_NIVEL_ACCESO,NIVEL_ACCESO_PERSONA_MAXIMO,NIVEL_ACCESO) )
            if NIVEL_ACCESO_PERSONA_MAXIMO >= NIVEL_ACCESO:
                print('Pase')
            else:
                print('NO pase')
            '''
            for ID,Nombre,Apellido,Estado in lista :

                print("asd %d, %d" % (Nombre, Apellido))
            '''
            '''
                con id_usuario me voy a mover en toda la base de datos para chequear
                A) Si el horario de entrada es el correcto
                .B) Si el usuario esta activo
                C) Si el usuario quiere entrar a un nivel Permitido
                .D) Identificarlo por nombre y apellido
                .E) Chequeo tag
            '''
        except:
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error
if __name__ == '__main__':
    bdd=ABM_rebasico('localhost', 'luciano', 'luciano', 'CONTROL_ACCESO')
    bdd.conectar()
    #bdd.listar_personas()
    #bdd.listar_puertas()
    id=bdd.chequear_tag(12345678) ## terminar de ver error handler
    bdd.identificar(id[0])
    bdd.verificar_nivel(id[0],1)
