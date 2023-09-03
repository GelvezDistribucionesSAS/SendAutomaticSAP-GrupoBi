#Importar modulos
import os
from decimal import Decimal
from .Conexion import conexion , conectMantis, conect_Mantis
from .ConvertirData import PasarArreglo, GuardarTexto 
from ..consultas.SalidaData import ReadSQL
from .VariablesGlobales import *
import numpy as np
from ..components.converTextData import ConverText 
from ..components.dataExtract import extracJSON

salesData = []
class CDTExtract:
    def __init__(self, DateYear, DateEnd, DateForma):
        self.DateYear = DateYear
        self.DateEnd = DateEnd
        self.DateForma = DateForma

    def salesCDTArauca (self):
        global salesData
        DataJson = extracJSON("cdtStructureSale.json")
        print(DataJson)
        for i in DataJson:
            print(i)
            text = ConverText.converGeneralText(DataJson[i]["NameFiles"],rutaCDT,
                                                DataJson[i]["CodCliente"],
                                                DataJson[i]["CodSede"],self.DateYear,
                                                DataJson[i]["InvGruCod"])
            dataSales = conectMantis(text)
            salesData.append(dataSales)
        
        print(salesData)
        GuardarTexto(salesData,RutaGlobal+CDT_Kimberly+f'Ventas_{self.DateForma}')
    def inventoryCDT(self):
        pass

    def ExecutorSales(self):
        pass 
        

    