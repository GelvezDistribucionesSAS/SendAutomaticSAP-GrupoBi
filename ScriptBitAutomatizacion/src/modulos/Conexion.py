"""
Modulo:Conexión 
Se  encargar de realizar la conecció a la base de datos hana
además de contener la función de la llamada de la consulta. 
"""

#Conexion a la base de datos.
from hdbcli import dbapi
import os
import dotenv

dotenv.load_dotenv()
def conect():
    conn = dbapi.connect(
    address=os.getenv('SERVER'),
    port='30015',
    user= os.getenv('USER'),
    password= os.getenv('PASSWORD')
    )
    print("conectado")
    return conn

#llamado del query
def conexion (Query):
    cursor = conect().cursor()
    cursor.execute(Query)
    return cursor





