from .VariablesGlobales import *
from .EnvioEmail import correo as cr
import datetime



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
    DatosConvert = []
    for i in Data:
        for j in i:
            DatosConvert.append(str(j))
    return DatosConvert

#Se encarga de generar el archivo con el error de lineas en blanco
def LogError(Data):
    with open (RutaGlobal+'LogError.txt' , 'a', encoding='utf-8') as t:
        t.write('\n')
        t.write(Data)
    cr()
        

"""
Funcción encarga de guardar el texto generado depues el procesamiento de los datos. 
"""
def GuardarTexto(Ingrese ,Ruta):
    with open(Ruta, "w",encoding='utf-8-sig') as f:
        for j in Ingrese:
            if j == "None":
                print("Error line vacia")
                LogError(Data="Error en el siguiente Archivo: "+Ruta )
                break
            else: 
                f.write(j+"\n")
            #print("Ingreso")
    f.close()




