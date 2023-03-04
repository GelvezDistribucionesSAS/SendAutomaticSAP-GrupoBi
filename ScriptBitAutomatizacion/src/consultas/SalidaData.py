#Modulos importados
import os.path
from ..modulos.VariablesGlobales import rutaBase

""" Para el proceso de seleccion del documento se incluye una condicción para estraer 
la información de la consulta 1:Cucuta 2:GranDistribuidor"""
#Importación de datos de formato sql a texto

class ReadSQL:
    """
    Clase encargada de leer la informacion de los archivos sql
    """
    def __init__ (self,schemeDB):
        self.schemeDB = schemeDB
        self.__CLIENTES = 'clientes.sql'
        self.__BARRIOS = 'Barrios.sql'
        self.__INVENTARIO = 'Inventario.sql'
        self.__MUNICIPIOS = 'Municipios.sql'
        self.__PRODUCTOS = 'Productos.sql'
        self.__TIPOSNEOGOCIOS = 'TiposNegocios.sql'
        self.__TOTALES = 'Totales.sql'
        self.__VENDEDORES = 'Vendedores.sql'
        self.__VENTAS = 'Ventas.sql'
        self.__INVENTARIOCOLGATE = 'InventarioC.sql'
        self.__PRODUCTOSCOLGATE = 'ProductosC.sql'
        self.__VENTASCOLGATE = 'Ventas1C.sql'
        self.__BARRIOSTOTAL = 'BarrioTotal.sql'
        self.__CLIENTESTOTAL = 'ClientesTotal.sql'
        self.__INVENTARIOTOTAL = 'IventarioTotal.sql'
        self.__PRODUCTOSTOTAL = 'productosTotal.sql'
        self.__SELLIN = 'Sellin.sql'
        self.__TOTALESTOTAL = 'TotalesTotal.sql'
        self.__VENDEDORESTOTAL = 'VendedoresTotal.sql'
        self.__VENTASTOTAL = 'VentasTotal.sql'
        self.__TIPOSNEOGOCIOSTOTAL = 'TipoNegocioTotal.sql'

    def read_customers(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__CLIENTES), 'r') as f:
            data = f.read()
        return data
    
    def read_neighborhood(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__BARRIOS), 'r') as f:
            data = f.read()
        return data
    
    def read_inventory(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__INVENTARIO), 'r') as f:
            data = f.read()
        return data
    
    def read_municipalities(self):
        data = """""" 
        with open(os.path.join(rutaBase, self.__MUNICIPIOS), 'r') as f:
            data = f.read()
        return data
    
    def read_products(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__PRODUCTOS), 'r') as f:
            data = f.read()
        return data
    
    def read_business_type(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__TIPOSNEOGOCIOS), 'r') as f:
            data = f.read()
        return data
        
    def read_totals(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__TOTALES), 'r') as f:
                data = f.read()
        return data

    def read_sellers(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__VENDEDORES), 'r') as f:
            data = f.read()
        return data    

    def read_sales(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__VENTAS), 'r') as f:
            data = f.read()
        return data

    def read_sales_colgate(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__VENTASCOLGATE), 'r') as f:
            data = f.read()
        return data  

    def read_inventory_colgate(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__INVENTARIOCOLGATE), 'r') as f:
            data = f.read()
        return data 

    def read_product_colgate(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__PRODUCTOSCOLGATE), 'r') as f:
            data = f.read()
        return data 
    
    #Salida de datos de Gelvez Total
    def  read_neighborhood_gelvez(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__BARRIOSTOTAL),'r') as f:
            data = f.read()
        return data
    
    def read_cunstomer_gelvez(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__CLIENTESTOTAL)) as f:
            data = f.read()
        return data
    
    def read_inventory_gelvez(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__INVENTARIOTOTAL)) as f:
            data = f.read()
        return data
    
    def read_products_gelvez(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__PRODUCTOSTOTAL)) as f:
            data = f.read()
        return data 

    def read_sellin_gelvez(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__SELLIN)) as f:
            data = f.read()
        return data

    def read_totals_gelvez(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__TOTALESTOTAL)) as f:
            data = f.read()
        return data
    
    def read_sellers_gelvez(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__VENDEDORESTOTAL)) as f:
            data = f.read()
        return data
    
    def read_sales_Gelvez(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__VENTASTOTAL)) as f:
            data = f.read()
        return data
    
    def read_bussiones_type_gelvez(self):
        data = """"""
        with open(os.path.join(rutaBase, self.__TIPOSNEOGOCIOSTOTAL)) as f:
            data = f.read()  
        return data
    
    