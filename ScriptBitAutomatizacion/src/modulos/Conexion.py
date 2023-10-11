"""
Modulo:Conexión 
Se  encargar de realizar la conecció a la base de datos hana
además de contener la función de la llamada de la consulta. 
Se agrega conexion a la DB basa en sql server para poderr hacer extrancion de datos
desde otra base de datos distinta.
"""

#Conexion a la base de datos.
from hdbcli import dbapi

import os
import dotenv
import pymssql


dotenv.load_dotenv()
def conect():
    conn = dbapi.connect(
    address= os.getenv('SERVER'),
    port='30015',
    user= os.getenv('USERDB'),
    password= os.getenv('PASSWORD')
    )
    print("conectado")
    return conn

#llamado del query
def conexion (Query):
    cursor = conect().cursor()
    cursor.execute(Query)
    return cursor

#Conexion de datos a de mantis

def conect_Mantis():
    conn = pymssql.connect(str(os.getenv('SERVERMANTIS')),
                           str(os.getenv('USERMANTIS')),
                           str(os.getenv('PASSWORDMANTIS')),
                           str(os.getenv('DBMANTIS')))
    return conn
    
def conectMantis(query):
    cursor = conect_Mantis().cursor()
    cursor.execute(query)
    return cursor.fetchall()



