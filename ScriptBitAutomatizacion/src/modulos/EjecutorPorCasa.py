#Importar modulos
import os

from .Conexion import conexion
from .ConvertirData import PasarArreglo, GuardarTexto
from ..consultas.SalidaData import ReadSQL
#from ..consultas.Salidad.Diccionario import *
from .VariablesGlobales import *


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

    def output_inventory_colgate(self):
        text =self.read_inventory().format(self.number_house, self.store, self.schemeDB, self.DateEnter, self.monthd)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + INVENTARIO))
        print('Se Genero: ' + INVENTARIO)
    
    def output_product_colgate(self):
        text = self.read_product_colgate().format(self.number_house, self.store, self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + SKU))
        print('Se Genero: ' + SKU)

    def output_sales_colgate(self):
        text = self.read_sales_colgate().format(self.number_house, self.DateEnter)
        data = conexion(text.replace('#','{'))
        data = PasarArreglo(data)
        GuardarTexto(data, os.path.join(RutaGlobal, self.house_route + VENTAS))
        print('Se Genero: '+ VENTAS)
    
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
    
    

