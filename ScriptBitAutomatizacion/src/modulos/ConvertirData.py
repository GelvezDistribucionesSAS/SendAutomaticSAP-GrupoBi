from .VariablesGlobales import *
from ..components.sendMail import sendMailEcxel as cr
from datetime import datetime, timedelta 
from ..components.dataExtract import extracJSON, getFilePath



"""
Modulo encargado de realizar el proceso del envio de la información junton con el procesamiento logico de la lectura dentro
de arreglos para el recorrido de los mismos. 

"""

def ConverData(IntroData):
    salidaData = []
    insert = ''
    for i in range(len(IntroData)):
        insert = ''
        insert += IntroData[i] + "{"
        salidaData.append(insert)
    

def PasarArreglo(Data):
    """
    Se encarga de convertir una tupla en un arreglo.
    """
    DatosConvert = []
    for i in Data:
        for j in i:
            DatosConvert.append(str(j))
    return DatosConvert


def LogError(Data):
    """
    Se encarga de generar el arhivo de log con el error reportado de lineas en blanco 
    """
    with open (RutaGlobal+'LogError.txt' , 'a', encoding='utf-8') as t:
        t.write('\n')
        t.write(Data)
    dataJSON = extracJSON(getFilePath('config','mail.json'))
    cr(sender= dataJSON['sender'],
       addressee= dataJSON['addressee'],
       affair='Error de envio Correo',
       menssage='menssaje.html',
       nameArchive= 'LogError.txt',
       password= dataJSON['password']
       )
        


def GuardarTexto(Ingrese ,Ruta):
    """
        Funcción encargada de guardar el texto generado depues el procesamiento de los datos. 
    """
    with open(Ruta, "w",encoding='utf-8') as f:
        for j in Ingrese:
            if j == "None":
                print("Error line vacia")
                LogError(Data="Error en el siguiente Archivo: "+Ruta )
                break
            else: 
                f.write(str(j)+"\n")
    f.close()


def dateNowHana():
    """Generar hora actual para formato de hana que se puede ejecutar en SQL"""
    date = datetime.now()
    date = date - timedelta(days=1)
    return date.strftime("%Y%m%d")


