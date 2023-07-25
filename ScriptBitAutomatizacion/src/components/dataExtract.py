import os, json

def getFilePath(folderName, fileName):
    """Relative path modeler"""
    currentDir = os.path.dirname(os.path.abspath(__file__))
    filePath = os.path.join(currentDir,'..', folderName, fileName)
    return filePath

def extracJSON(NameArchive):
    """Ingresar el nombre del archivo Json a leer y traduccir"""
    dataJSON: dict = open(getFilePath('config', NameArchive), "r")
    dataJSON = json.loads(str(dataJSON.read()))
    return dataJSON