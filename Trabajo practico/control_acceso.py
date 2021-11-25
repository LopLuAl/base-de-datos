#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys
import MySQLdb
import datetime
import time


class ABM_CONTROL_ACCESO:
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
                return True
            else:
                print('NO pase')
                return False
        except:
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error
    def verificar_hora_entrada(self):
        if not self._verifica_conexion():
            return False
        error = False
        try:
            cur = self._conn.cursor()
            cur.execute("select hora_entrada from Horario_laboral where Workplace = '1' and now() >= Hora_Entrada" )
            lista = cur.fetchall()

            if lista:
                print('Horario laboral Permitido')
                return True
            else:
                print('Horario laboral no permitdo el ingreso')
                return False

        except:
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error


    def modificar_estadistica(self, tag_id,permitido,denegado,id):
        '''
            `TAG_ID`,`Permitido`,`Denegados`,`ID
        '''
        if not self._verifica_conexion():
            return False
        error = False
        try:
            cur = self._conn.cursor()
            cur.execute("SELECT Permitido, Denegados FROM Puerta_estadistica WHERE ID="+"'"+str(id)+"'")
            lista = cur.fetchall()

            if permitido:
                permitido=lista[0][0]+1
            if denegado:
                denegado=lista[0][1]+1

            cur.execute("UPDATE Puerta_estadistica SET TAG_ID="+"'"+str(tag_id)+"'"+",Permitido="+"'"+str(permitido)+"'"+",Denegados= "+"'"+str(denegado)+"'"+" WHERE ID="+"'"+str(id)+"'")
        except:
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error
    def mostrar_estadistica(self,id):
        '''
            `TAG_ID`,`Permitido`,`Denegados`,`ID
        '''
        if not self._verifica_conexion():
            return False
        error = False
        try:
            cur = self._conn.cursor()
            cur.execute("SELECT * FROM Puerta_estadistica WHERE ID="+"'"+str(id)+"'")
            lista = cur.fetchall()
            for TAG_ID,Permitido,Denegados,ID in lista :
                print("---Estadisitca--- \n|Ultimo TAG ID: %d |\n|Permitidos: %d    |\n|Denegados : %d   |" % (TAG_ID, Permitido,Denegados))
        except:
            print(sys.exc_info()[1])
            error = True
        finally:
            cur.close()
        return error

if __name__ == '__main__':
    id_pueta = 1
    bdd=ABM_CONTROL_ACCESO('localhost', 'luciano', 'luciano', 'CONTROL_ACCESO')
    bdd.conectar()
    id_tag=bdd.chequear_tag(12345678) ## terminar de ver error handler
    if bdd.identificar(id_tag[0]) == True:
        if bdd.verificar_nivel(id_tag[0],1) == True:
            if bdd.verificar_hora_entrada() == True:
                print('Bienvendio')
                bdd.modificar_estadistica(self, id_tag[0],1,0,id_pueta)
            else:
                print('---NO---')
                bdd.modificar_estadistica(id_tag[0],0,1,id_pueta)
    bdd.mostrar_estadistica(id_pueta)
    #TODO:
    '''
        Modificar estadistica

        Imprimir estadistica

    '''
