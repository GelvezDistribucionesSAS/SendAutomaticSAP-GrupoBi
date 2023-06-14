#Importar modulos
import os
from decimal import Decimal
from .Conexion import conexion , conectMantis, conect_Mantis
from .ConvertirData import PasarArreglo, GuardarTexto
from ..consultas.SalidaData import ReadSQL
from .VariablesGlobales import *
import numpy as np


#Estructuras de control 
class GenerateFiles(ReadSQL):
    def __init__(self, house_route, number_house, userFTP, password ,store, schemeDB, DateEnter, monthd):
        self.house_route = house_route
        self.number_house = number_house
        self.userFTP = userFTP
        self.password = password
        self.store = store
        self.DateEnter = DateEnter
        self.monthd = monthd
        
        ReadSQL.__init__(self,schemeDB)
    #Salida de municipios
    def output_municipality(self):
        datos = conexion((self.read_municipalities().format(self.schemeDB)).replace('#','{'))
        datos = PasarArreglo(datos)
        GuardarTexto(datos,os.path.join(RutaGlobal,self.house_route + MUNICIPIOS))
        print('Se genero: '+ MUNICIPIOS)
        
    def output_customers(self):
        text =self.read_customers().format(self.number_house, self.store, self.schemeDB, self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data,os.path.join(RutaGlobal,self.house_route + CLIENTES))
        print('Se genero: ' + CLIENTES)
    
    def output_inventory(self):
        text =self.read_inventory().format(self.number_house, self.store, self.schemeDB, self.DateEnter, self.monthd)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data,os.path.join(RutaGlobal,self.house_route + INVENTARIO))
        print('Se Genero: ' + INVENTARIO)
    
    def output_business_type(self):
        text = self.read_business_type().format(self.schemeDB)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data,os.path.join(RutaGlobal, self.house_route + TIPOSNEGOCIOS))
        print('Se Genero: ' + TIPOSNEGOCIOS)
    
    def output_totals(self):
        text = self.read_totals().format(self.number_house, self.store, self.schemeDB, self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + TOTALES))
        print('Se Genero: ' + TOTALES)

    def output_sellers(self):
        text = self.read_sellers().format(self.number_house, self.store, self.schemeDB, self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + VENDEDORES))
        print('Se Genero: ' + VENDEDORES)
    
    def output_sales(self):
        text = self.read_sales().format(self.number_house, self.store, self.schemeDB, self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + VENTAS))
        print('Se Genero: ' + VENTAS)

    def output_products(self):
        text = self.read_products().format(self.number_house, self.store, self.schemeDB, self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + SKU))
        print('Se Genero: ' + SKU)
    
    def output_neighborhood(self):
        text = self.read_neighborhood().format(self.number_house, self.store, self.schemeDB, self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + BARRIOS))
        print('Se Genero: ' + BARRIOS)
    
    #Salidas especiales

#Salida de colgate
    def output_inventory_colgate(self):
        text =self.read_inventory_colgate().format(self.number_house, self.store, self.schemeDB, self.DateEnter, self.monthd)
        data = conexion(text.replace('#','{'))
        conect_Mantis()
        #Generar Arauca
        text = self.read_inventory_arauca()
        data2 = conectMantis(text)
        result = np.concatenate((np.array(data.fetchall()),np.array(data2)), axis=None)
        GuardarTexto(result, os.path.join(RutaGlobal, self.house_route + INVENTARIO))
        print('Se Genero: ' + INVENTARIO)

    def output_customers_colgate(self):
        text =self.read_customers().format(self.number_house, self.store, self.schemeDB, self.DateEnter)
        data = conexion(text.replace('#','{'))
        #generar arauca
        text = self.read_customers_arauca()
        data2 = conectMantis(text)
        result = np.concatenate((np.array(data.fetchall()),np.array(data2)), axis=None)
        GuardarTexto(result,os.path.join(RutaGlobal,self.house_route + CLIENTES))
        print('Se genero: ' + CLIENTES)
    
    def output_product_colgate(self):
        text = self.read_product_colgate().format(self.number_house, self.store, self.DateEnter)
        data = conexion(text.replace('#','{'))
        #Enerar arauca
        text = self.read_sku_arauca()
        data2 = conectMantis(text)
        result = np.concatenate((np.array(data.fetchall()),np.array(data2)), axis= None)
        GuardarTexto(result, os.path.join(RutaGlobal, self.house_route + SKU))
        print('Se Genero: ' + SKU)

    def output_sales_colgate(self):
        text = self.read_sales_colgate().format(self.number_house, self.store, self.schemeDB, self.DateEnter)
        data = conexion(text.replace('#','{'))
        #Generar Arauca
        text = self.read_sales_arauca()
        data2 = conectMantis(text)
        result = np.concatenate((np.array(data.fetchall()),np.array(data2)),axis=None)
        GuardarTexto(result, os.path.join(RutaGlobal, self.house_route + VENTAS))
        print('Se Genero: '+ VENTAS)
    #Total control Colgate
    def output_totales_colgate(self):
        text = self.read_totales_arauca().format(self.number_house, self.store, self.schemeDB, self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data.fetchall())
        #Generar Arauca
        text = self.read_control_arauca()
        data2 = conectMantis(text)
        data2 = PasarArreglo(data2)
        result = float(data[0]) + float(data2[0])
        print(result)
        result = [str('TotalValorVenta{'+str(result))]
        GuardarTexto(result, os.path.join(RutaGlobal, self.house_route + TOTALES))
        print('Se Genero: '+ TOTALES)
    #Generar vendedores
    def output_sellers_colgate(self):
        text = self.read_sellers().format(self.number_house, self.store, self.schemeDB, self.DateEnter)
        data = conexion(text.replace('#','{'))
        #Generar  vendedores
        text = self.read_sellers_arauca()
        data2 = conectMantis(text)
        result = np.concatenate((np.array(data.fetchall()),np.array(data2)), axis= None)
        GuardarTexto(result, os.path.join(RutaGlobal, self.house_route + VENDEDORES))
        print('Se Genero: ' + VENDEDORES)
    #Generar tipo negocio
    def output_business_type_colgate(self):
        text = self.read_business_type().format(self.schemeDB)
        data = conexion(text.replace('#','{'))
        #generar tipo matis
        text = self.read_TypeBussiones_arauca()
        data2 = conectMantis(text)
        result = np.concatenate((np.array(data.fetchall()), np.array(data2)), axis= None)
        GuardarTexto(result,os.path.join(RutaGlobal, self.house_route + TIPOSNEGOCIOS))
        print('Se Genero: ' + TIPOSNEGOCIOS)
    
    #Genered Totals

    def output_neighborhood_total(self):
        text = self.read_neighborhood_gelvez().format(self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + BARRIOS))
        print('Se genero: ' + BARRIOS)
        
    def output_customers_total(self):
        text =self.read_cunstomer_gelvez().format(self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data,os.path.join(RutaGlobal,self.house_route + CLIENTES))
        print('Se genero: ' + CLIENTES)
    
    def output_inventory_total(self):
        text =self.read_inventory_gelvez().format(self.DateEnter, self.monthd)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data,os.path.join(RutaGlobal,self.house_route + INVENTARIO))
        print('Se Genero: ' + INVENTARIO)
    
    def output_business_type_total(self):
        text = self.read_bussiones_type_gelvez()
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data,os.path.join(RutaGlobal, self.house_route + TIPOSNEGOCIOS))
        print('Se Genero: ' + TIPOSNEGOCIOS)
    
    def output_totals_total(self):
        text = self.read_totals_gelvez().format(self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + TOTALES))
        print('Se Genero: ' + TOTALES)

    def output_sellers_total(self):
        text = self.read_sellers_gelvez().format(self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + VENDEDORES))
        print('Se Genero: ' + VENDEDORES)
    
    def output_sales_total(self):
        text = self.read_sales_Gelvez().format(self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + VENTAS))
        print('Se Genero: ' + VENTAS)

    def output_products_total(self):
        text = self.read_products_gelvez().format(self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + SKU))
        print('Se Genero: ' + SKU)
    
    def output_sellin_total(self):
        text = self.read_sellin_gelvez().format(self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + SELLIN))
        print('Se Genero: ' + SELLIN)
    
    

