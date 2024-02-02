import os
from ..modulos.VariablesGlobales import *
class ConverText:

    def converTextFormatSQLArauca(fileNameSQL, *vars):
        querySQL = open(os.path.join(rutaArauca, fileNameSQL))
        querySQL = str(querySQL.read()).format(*vars)
        querySQL = querySQL.replace('#','{')
        return querySQL
    
    def converGeneralText(fileNameSQL,PathFolder,*vars):
        print(*vars)
        querySQL = open(os.path.join(PathFolder, fileNameSQL))
        querySQL = str(querySQL.read()).format(*vars)
        querySQL = querySQL.replace('#','{')
        return querySQL

