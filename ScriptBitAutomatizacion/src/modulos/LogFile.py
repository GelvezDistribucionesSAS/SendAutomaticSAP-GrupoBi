#Modulos a importar
from .EjecutorPorCasa import GenerateFiles
from .VariablesGlobales import *
from .Comprimir import Comprimir01, LimpiarRuta , ComprimirNestle, compress_total
from time import time
from .ModuloFtp import send_FTP
import os
import dotenv

dotenv.load_dotenv()
""" La siguiente estructura se encarga de la gestion del llamado de modulos para la validación de los mismos por casa 

Rutas : Es la Variable de la Ruta Global
casaruta : Es la variable que contiene el nombre de la carpeta de la casa
NameArchivo : Es la varible que contiene el nombre del archivo de texto a generar Esta de define en el modulo ejecutor casa
cede : Define las cede 1 para cucuta 2 para gran distribuidor
condiciòn: Define el llamado desde el diccionario a que casa pertene  la consulta de condicciòn de los datos.
"""

########################### Decorador Time ejecución #####################################

def count_elapsed_time(f):
    """
    Decorator.
    Execute the function and calculate the elapsed time.
    Print the result to the standard output.
    """
    def wrapper():
        # Start counting.
        start_time = time()
        # Take the original function's return value.
        ret = f()
        # Calculate the elapsed time.
        elapsed_time = time() - start_time
        print("Elapsed time: %0.1f seconds." % elapsed_time)
        return ret
    
    return wrapper

##########################################################################################
#casas
class ExecutionHouse:
    @count_elapsed_time
    def bellezacucuta():
        be = GenerateFiles(Belleza, 157, 'user_falta', 'password_falta', '006', 'HBTGELVEZ_CUCUTA')
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,BellezaCucuta)
        LimpiarRuta(RutaGlobal + be.house_route)
       
    
    @count_elapsed_time
    def nestlecucuta():
        ns = GenerateFiles(cu_NESTLE_212385, 154, os.getenv('USERNESTLECUCUTA'), os.getenv('PASSWORDNESTLECUCUTA'), '006', 'HBTGELVEZ_CUCUTA')
        ns.output_municipality()
        ns.output_customers()
        ns.output_business_type()
        ns.output_inventory()
        ns.output_products()
        ns.output_sales()
        ns.output_sellers()
        ns.output_totals()
        ns.output_neighborhood()
        ComprimirNestle(cu_NESTLE_212385,NestleCucuta)
        LimpiarRuta(RutaGlobal + cu_NESTLE_212385 )
        send_FTP(ns.userFTP,ns.password,RutaGlobal,ns.house_route,NestleCucuta)
    
    def cucuta_edgewell():
        be = GenerateFiles(cu_EDGEWELL_209759, 156, os.getenv('USEREDGEWELLCUCUTA'), os.getenv('PASSWORDEDGEWELLCUCUTA'), '006', 'HBTGELVEZ_CUCUTA')
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route, EdgewellCucuta)
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP,be.password,RutaGlobal,be.house_route,EdgewellCucuta)
    
    def cucuta_energizer():
        be = GenerateFiles(cu_ENERGIZER_210760, 151, 'user_falta', 'password_falta', '006', 'HBTGELVEZ_CUCUTA')
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,EnergeizerCucuta)
        LimpiarRuta(RutaGlobal + be.house_route)

    def cucuta_HDV():
        be = GenerateFiles(cu_HDV_208514, 151, 'user_falta', 'password_falta', '006,030', 'HBTGELVEZ_CUCUTA')
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,HdvCucuta)
        LimpiarRuta(RutaGlobal + be.house_route)

    def cucuta_kimberly_ICH():
        be = GenerateFiles(cu_KIMBERLY_208903, 144, 'user_falta', 'password_falta', '006,030', 'HBTGELVEZ_CUCUTA')
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,KimberlyIchCucuta)
        LimpiarRuta(RutaGlobal + be.house_route)
    

    def cucuta_kimberly_pañaleras():
        be = GenerateFiles(cu_PAÑ_KIMBERLY_209321, 144, 'user_falta', 'password_falta', '006,030','HBTGELVEZ_CUCUTA')
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,KimberlyPañCucuta)
        LimpiarRuta(RutaGlobal + be.house_route)  

    def cucuta_colgate():
        be = GenerateFiles(cu_COLGATE_210973, 150, 'user_falta', 'password_falta', '006,030', 'HBTGELVEZ_CUCUTA')
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory_colgate()
        be.output_product_colgate()
        be.output_sales_colgate()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,ColgateCucuta)
        LimpiarRuta(RutaGlobal + be.house_route)

    def cali_pañ_kimberly():
        be = GenerateFiles(CAL_PAÑ_KIMBERLY_210541, 145, 'user_falta','password_falta','010,019', 'HBTGRANDISTRIBUIDOR')
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,kimberlyPañGiron)
        LimpiarRuta(RutaGlobal + be.house_route)  

    def Giron_kimberly_ICH():
        be = GenerateFiles(gir_ICH_KIMBERLY_209968, 144, 'user_falta', 'password_falta', '014', 'HBTGRANDISTRIBUIDOR')
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,kimberlyIchGiron)
        LimpiarRuta(RutaGlobal + be.house_route)    

    def giron_edgwell():
        be = GenerateFiles(gir_EDGWELL_211187, 156, os.getenv('USEREDGEWELLGIRON'), os.getenv('PASSWORDEDGEWELLGIRON'), '014', 'HBTGRANDISTRIBUIDOR')
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,edgewellGiron)
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP,be.password,RutaGlobal,be.house_route, edgewellGiron)
    def giron_eveready():
        be = GenerateFiles(gir_EVEREADY_210761, 151, 'user_falta', 'password_falta', '014', 'HBTGRANDISTRIBUIDOR')
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,energeizerGiron)
        LimpiarRuta(RutaGlobal + be.house_route)

    def giron_nestle():
        be = GenerateFiles(gir_NESTLE_211851, 154, os.getenv('USERNESTLEGIRON'), os.getenv('PASSWORDNESTLEGIRON'), '014', 'HBTGRANDISTRIBUIDOR')
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,nestleGiron)
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP,be.password,RutaGlobal,be.house_route,nestleGiron)
    
    def total_gelvez():
        tl = GenerateFiles(total_GELVEZ, 144, os.getenv('USERTOTALGELVEZ'), os.getenv('PASSWORDTOTALGELVEZ'), 'NullStore', 'HBTGRANDISTRIBUIDOR')
        tl.output_neighborhood_total()
        tl.output_municipality()
        tl.output_customers_total()
        tl.output_business_type_total()
        tl.output_inventory_total()
        tl.output_products_total()
        tl.output_sellin_total()
        tl.output_sales_total()
        tl.output_sellers_total()
        tl.output_totals_total()
        compress_total(tl.house_route, totalGelvez)
        LimpiarRuta(RutaGlobal + tl.house_route)
        send_FTP(tl.userFTP,tl.password,RutaGlobal,tl.house_route,totalGelvez)


