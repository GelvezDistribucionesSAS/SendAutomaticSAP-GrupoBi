#Importar modulos
import os
from .Conexion import conexion , conectMantis
from .ConvertirData import PasarArreglo, GuardarTextoCDT
from .VariablesGlobales import *
from ..components.converTextData import ConverText 
from ..components.dataExtract import extracJSON
from .ModuloFtp import sendFTPCDT
import dotenv

dotenv.load_dotenv()
salesData = []
inventoryData = []
class CDTExtract:
    def __init__(self, DateYear, DateEnd, DateForma,StartDate):
        self.DateYear = DateYear
        self.DateEnd = DateEnd
        self.DateForma = DateForma
        self.StartDate = StartDate

    # def salesCDTArauca (self):
    #     global salesData
    #     DataJson = extracJSON("cdtStructureSaleArauca.json")
    #     print("Sale Arauca")
    #     for i in DataJson:
    #         print(i)
    #         text = ConverText.converGeneralText(DataJson[i]["NameFiles"],rutaCDT,
    #                                             DataJson[i]["CodCliente"],
    #                                             DataJson[i]["CodSede"],self.DateYear,
    #                                             DataJson[i]["InvGruCod"])
    #         dataSales = conectMantis(text)
    #         dataSales = PasarArreglo(dataSales)
    #         salesData.append(dataSales)
        
    def salesCDTSAP(self):
        global salesData
        DataJson = extracJSON("cdtSaleSAP.json")
        print("Sale SAP")
        for i in DataJson:
            print(i)
            
            text = ConverText.converGeneralText(DataJson[i]["NameFiles"],rutaCDT,
                                                DataJson[i]["CodCliente"],
                                                DataJson[i]["CodSede"],
                                                DataJson[i]["InvGruCod"],
                                                DataJson[i]["WhsCode"],
                                                DataJson[i]["Schema"],
                                                self.StartDate, self.DateEnd)                                              
            dataSales = conexion(text)
            dataSales = PasarArreglo(dataSales)
            salesData.append(dataSales)      
    
    # def inventoryCDTArauca(self):
    #     global inventoryData
    #     DataJson = extracJSON("inventoryArauca.json")
    #     print("inventory Arauca")
    #     for i in DataJson:
    #         print(i)
    #         text = ConverText.converGeneralText(DataJson[i]["NameFiles"],rutaCDT,
    #                                             DataJson[i]["CodCliente"],
    #                                             DataJson[i]["CodSede"],self.DateForma,
    #                                             DataJson[i]["InvGruCod"], self.DateEnd)
    #         dataSales = conectMantis(text)
    #         dataSales = PasarArreglo(dataSales)
    #         inventoryData.append(dataSales)

    def inventoryCDTDAP(self):
        global inventoryData
        DataJson = extracJSON("inventorySAP.json")
        print("Sale SAP")
        for i in DataJson:
            print(i)
            text = ConverText.converGeneralText(DataJson[i]["NameFiles"],rutaCDT,
                                                DataJson[i]["CodCliente"],
                                                DataJson[i]["CodSede"], self.DateForma,
                                                DataJson[i]["Schema"],
                                                DataJson[i]["WhsCode"],
                                                DataJson[i]["InvGruCod"],
                                                self.DateEnd)
            dataSales = conexion(text)
            dataSales = PasarArreglo(dataSales)
            inventoryData.append(dataSales) 

    def ExecutorSales(self):
        global salesData 
        global inventoryData
        # self.salesCDTArauca()
        self.salesCDTSAP()
        GuardarTextoCDT(salesData,RutaGlobal+CDT_Kimberly+f'Ventas_{self.DateEnd}.txt')
        print("----Se Genero Ventas----------")
        # self.inventoryCDTArauca()
        self.inventoryCDTDAP()
        GuardarTextoCDT(inventoryData,RutaGlobal+CDT_Kimberly+f'Inventario_{self.DateEnd}.txt')
        print("----Se Genero Inventario------")
        sendFTPCDT(os.getenv("CDTHOST"), os.getenv("CDTUSER"), os.getenv("CDTPASSWORD") ,RutaGlobal, CDT_Kimberly,f'Ventas_{self.DateEnd}.txt')
        print("----Se envio Ventas-------")
        sendFTPCDT(os.getenv("CDTHOST"), os.getenv("CDTUSER"), os.getenv("CDTPASSWORD") ,RutaGlobal, CDT_Kimberly,f'Inventario_{self.DateEnd}.txt')
        print("-----Se envio Inventario")
