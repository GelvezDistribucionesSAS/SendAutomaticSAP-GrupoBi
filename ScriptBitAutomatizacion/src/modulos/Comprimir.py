import os 
import zipfile
from datetime import date , timedelta
from .VariablesGlobales import data, dataNestle, RutaGlobal, dataTotal
import glob



def Comprimir01(HomeFolfer,NameHome):
    """
    Modulo comprección:
    Se encarga de comprimir cada uno de los archivos según la estructura que se solicita,
    Contiene además la funcción  de limpieza que se encarga de elimar los arhivos una vez que este comprimidos.
    """
    try: 
        import zlib
        compression = zipfile.ZIP_DEFLATED
    except:
        compression = zipfile.ZIP_DEFLATED
    DataCompress = zipfile.ZipFile(RutaGlobal+HomeFolfer+NameHome, mode='w')
    try:
        for datos in data:
            DataCompress.write(os.path.join(RutaGlobal+HomeFolfer)+datos,arcname=datos, compress_type= compression)
        print("Compreción Finalizada del archivo ", NameHome )
    finally:
        DataCompress.close()

    DataCompress.close()


def ComprimirNestle(HomeFolfer,NameHome):
    """ 
    Funcion encargada de realizar la compreción de la casa de nestle por que maneja mas archivos.
    """
    try: 
        import zlib
        compression = zipfile.ZIP_DEFLATED
    except:
        compression = zipfile.ZIP_DEFLATED
    DataCompress = zipfile.ZipFile(RutaGlobal+HomeFolfer+NameHome, mode='w')
    try:
        for datos in dataNestle:
            DataCompress.write(os.path.join(RutaGlobal+HomeFolfer)+datos,arcname=datos, compress_type= compression)
        print("Compreción Finalizada del archivo ", NameHome )
    finally:
        DataCompress.close()

    DataCompress.close()

def LimpiarRuta(HomeFolder):
    """Función encargada de limpiar las diferentes salidas de solo texto."""
    py_files=glob.glob(HomeFolder+'*.txt')

    for pyfile in py_files:
        try: 
            os.remove(str(pyfile))
            
        except OSError as e:
            print(f"Error:{e.strerror}")
    print("Eliminado")


def compress_total(HomeFolder,NameHome):
    """Comprimir los archivos de Gelvez  Total. """
    try: 
        import zlib
        compression = zipfile.ZIP_DEFLATED
    except:
        compression = zipfile.ZIP_DEFLATED
    DataCompress = zipfile.ZipFile(RutaGlobal+HomeFolder+NameHome, mode='w')
    try:
        for datos in dataTotal:
            DataCompress.write(os.path.join(RutaGlobal+HomeFolder)+datos,arcname=datos, compress_type= compression)
        print("Compreción Finalizada del archivo ", NameHome )
    finally:
        DataCompress.close()

    DataCompress.close()