#Modulos a importar
from .EjecutorPorCasa import GenerateFiles
from .VariablesGlobales import *
from .Comprimir import Comprimir01, LimpiarRuta , ComprimirNestle, compress_total
from time import time
from .ModuloFtp import send_FTP
import os
import dotenv
from .ExtractCDT import CDTExtract
dotenv.load_dotenv()


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
varData , monht, enter, mes, years, datefin, dateinit , dateformat = control()
##########################################################################################
#casas
class ExecutionHouse:
    """ La siguiente estructura se encarga de la gestion del llamado de modulos para la validación de los mismos por casa 

Rutas : Es la Variable de la Ruta Global
casaruta : Es la variable que contiene el nombre de la carpeta de la casa
NameArchivo : Es la varible que contiene el nombre del archivo de texto a generar Esta de define en el modulo ejecutor casa
cede : Define las cede 1 para cucuta 2 para gran distribuidor
condiciòn: Define el llamado desde el diccionario a que casa pertene  la consulta de condicciòn de los datos.
"""
    @count_elapsed_time
    def bellezacucuta():
        be = GenerateFiles(Belleza, 157, os.getenv('USERBELLEZACUCUTA'), os.getenv('PASSWORDBELLEZA'), '006,030', 'HBTGELVEZ_CUCUTA', varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,BellezaCucuta.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP, be.password,RutaGlobal, be.house_route, BellezaCucuta.format(enter))
       
    
    @count_elapsed_time
    def nestlecucuta():
        ns = GenerateFiles(cu_NESTLE_212385, 154, os.getenv('USERNESTLECUCUTA'), os.getenv('PASSWORDNESTLECUCUTA'), '006,030', 'HBTGELVEZ_CUCUTA',varData, monht, datefin)
        ns.output_municipality()
        ns.output_customers()
        ns.output_business_type()
        ns.output_inventory()
        ns.output_products()
        ns.output_sales()
        ns.output_sellers()
        ns.output_totals()
        ns.output_neighborhood()
        ComprimirNestle(cu_NESTLE_212385,NestleCucuta.format(enter))
        LimpiarRuta(RutaGlobal + cu_NESTLE_212385 )
        send_FTP(ns.userFTP,ns.password,RutaGlobal,ns.house_route,NestleCucuta.format(enter))
    
    def cucuta_edgewell():
        be = GenerateFiles(cu_EDGEWELL_209759, 156, os.getenv('USEREDGEWELLCUCUTA'), os.getenv('PASSWORDEDGEWELLCUCUTA'), '006,030,011', 'HBTGELVEZ_CUCUTA',varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route, EdgewellCucuta.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP,be.password,RutaGlobal,be.house_route,EdgewellCucuta.format(enter))
    
    def cucuta_energizer():
        be = GenerateFiles(cu_ENERGIZER_210760, 151, os.getenv('USERCUCUTAENERGIZER'), os.getenv('PASSWORDCUCUTAENERGIZER'), '006', 'HBTGELVEZ_CUCUTA',varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales_energizer()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,EnergeizerCucuta.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP,be.password,RutaGlobal,be.house_route,EnergeizerCucuta.format(enter))

    def cucuta_HDV():
        be = GenerateFiles(cu_HDV_208514, 146, os.getenv('USERHDVCUCUTA'), os.getenv('PASSWORDHDVCUCUTA'), '006,030', 'HBTGELVEZ_CUCUTA',varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,HdvCucuta.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP, be.password, RutaGlobal, be.house_route, HdvCucuta.format(enter))

    def cucuta_kimberly_ICH():
        be = GenerateFiles(cu_KIMBERLY_208903, 144, os.getenv('USERICHCUCUTANEW'), os.getenv('PASSWORDICHCUCUTA'), '006', 'HBTGELVEZ_CUCUTA',varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,KimberlyIchCucuta.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP,be.password,RutaGlobal,be.house_route,KimberlyIchCucuta.format(enter))
    

    def cucuta_kimberly_pañaleras():
        be = GenerateFiles(cu_PAÑ_KIMBERLY_209321, 145, os.getenv('USERICHCUCUTAPA'), os.getenv('PASSWORDICHCUCUTAPA'), '006','HBTGELVEZ_CUCUTA',varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,KimberlyPañCucuta.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP,be.password,RutaGlobal,be.house_route,KimberlyPañCucuta.format(enter))

    def cucuta_colgate():
        be = GenerateFiles(cu_COLGATE_210973, 150, os.getenv('USERCOLGATECUCUTA'), os.getenv('PASSWORDCOLGATECUCUTA'), '006,030', 'HBTGELVEZ_CUCUTA',varData, monht, datefin)
        #print(mes, año)
        be.output_municipality()
        be.output_customers_colgate()
        be.output_business_type_colgate()
        be.output_inventory_colgate()
        be.output_product_colgate()
        be.output_sales_colgate()
        be.output_sellers_colgate()
        be.output_totales_colgate()
        Comprimir01(be.house_route,ColgateCucuta.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP, be.password, RutaGlobal, be.house_route, ColgateCucuta.format(enter))




    def jgb_cucuta():
        be = GenerateFiles(JGB_213528, 148, os.getenv('USERJGBCU'), os.getenv('PASSWORDJGBCU'), '006,030', 'HBTGELVEZ_CUCUTA', varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products_jgb()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route, JGBCucuta.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP, be.password,RutaGlobal, be.house_route, JGBCucuta.format(enter))


    def jgb_giron():
        be = GenerateFiles(JGB_213529, 148, os.getenv('USERJGBGD'), os.getenv('PASSWORDJGBGD'), '014', 'HBTGRANDISTRIBUIDOR', varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products_jgb()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,JGBGiron.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP, be.password,RutaGlobal, be.house_route, JGBGiron.format(enter))



    def cali_pañ_kimberly():
        be = GenerateFiles(CAL_PAÑ_KIMBERLY_210541, 145, os.getenv('USERCALIICH'),os.getenv('PASSWORDCALIICH'),'010,019', 'HBTGRANDISTRIBUIDOR',varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,kimberlyPañGiron.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)  
        send_FTP(be.userFTP,be.password,RutaGlobal,be.house_route,kimberlyPañGiron.format(enter))
        
    def Giron_kimberly_ICH():
        be = GenerateFiles(gir_ICH_KIMBERLY_209968, 144, os.getenv('USERGIRONICH'), os.getenv('PASSWORDGIRONICH'), '014', 'HBTGRANDISTRIBUIDOR',varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,kimberlyIchGiron.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP,be.password,RutaGlobal,be.house_route,kimberlyIchGiron.format(enter))   

    def giron_edgwell():
        be = GenerateFiles(gir_EDGWELL_211187, 156, os.getenv('USEREDGEWELLGIRON'), os.getenv('PASSWORDEDGEWELLGIRON'), '014', 'HBTGRANDISTRIBUIDOR',varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,edgewellGiron.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP,be.password,RutaGlobal,be.house_route, edgewellGiron.format(enter))

    def giron_eveready():
        be = GenerateFiles(gir_EVEREADY_210761, 151, os.getenv('USERENEGIZERGIRON'), os.getenv('PASSWORDENERGIZERGIRON'), '014', 'HBTGRANDISTRIBUIDOR',varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales_energizer()
        be.output_sellers()
        be.output_totals()
        Comprimir01(be.house_route,energeizerGiron.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP, be.password, RutaGlobal, be.house_route, energeizerGiron.format(enter) )

    def giron_nestle():
        be = GenerateFiles(gir_NESTLE_211851, 154, os.getenv('USERNESTLEGIRON'), os.getenv('PASSWORDNESTLEGIRON'), '014', 'HBTGRANDISTRIBUIDOR',varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        be.output_neighborhood()
        ComprimirNestle(be.house_route,nestleGiron.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP,be.password,RutaGlobal,be.house_route,nestleGiron.format(enter))

    def giron_nestleCandelaria():
        be = GenerateFiles(gir_NESTLE_212587, 154, os.getenv('USERCANDELARIA'), os.getenv('PASSWORDCANDELARIA'), '010,019', 'HBTGRANDISTRIBUIDOR',varData, monht, datefin)
        be.output_municipality()
        be.output_customers()
        be.output_business_type()
        be.output_inventory()
        be.output_products()
        be.output_sales()
        be.output_sellers()
        be.output_totals()
        be.output_neighborhood()
        ComprimirNestle(be.house_route,nestleCaliEje.format(enter))
        LimpiarRuta(RutaGlobal + be.house_route)
        send_FTP(be.userFTP,be.password,RutaGlobal,be.house_route,nestleCaliEje.format(enter))
    
    def total_gelvez():
        tl = GenerateFiles(total_GELVEZ, 144, os.getenv('USERTOTALGELVEZ'), os.getenv('PASSWORDTOTALGELVEZ'), 'NullStore', 'HBTGRANDISTRIBUIDOR',varData, monht, datefin)
        tl.output_neighborhood_total()
        tl.output_municipality()
        tl.output_customers_total()
        tl.output_business_type_total()
        tl.output_inventory_total()
        tl.output_products_total() #SKU
       # tl.output_sellin_total() #
        tl.output_sales_total()
        tl.output_sellers_total()
        tl.output_totals_total()
        compress_total(tl.house_route, totalGelvez.format(enter))
        LimpiarRuta(RutaGlobal + tl.house_route)
        send_FTP(tl.userFTP,tl.password,RutaGlobal,tl.house_route,totalGelvez.format(enter))

    def brisan_Arauca():
        a = GenerateFiles(Ara_BRINSA,1,os.getenv('USERBRINSA'), os.getenv('PASSWORDBRINSA'),'NullStore','HBTGELVEZ_CUCUTA',varData, monht, datefin)
        a.customerArauca()
        a.iventoryArauca()
        a.skuArauca()
        a.typeBussionesArauca()
        a.controlTotalArauca()
        a.salesArauca()
        a.sellersArauca()
        a.output_municipality()
        Comprimir01(a.house_route,brinsaArauca.format(enter))
        LimpiarRuta(RutaGlobal+a.house_route)
        send_FTP(a.userFTP, a.password, RutaGlobal, a.house_route, brinsaArauca.format(enter))

    def jgb_arauca():
        a = GenerateFiles(JGB_213376,2,os.getenv('USERJGBAR'), os.getenv('PASSWORDJGBAR'),'NullStore','HBTGELVEZ_CUCUTA',varData, monht, datefin)
        a.customerArauca()
        a.iventoryArauca()
        a.skuArauca()
        a.typeBussionesArauca()
        a.controlTotalArauca()
        a.salesArauca()
        a.sellersArauca()
        a.output_municipality()
        Comprimir01(a.house_route,JGBArauca.format(enter))
        LimpiarRuta(RutaGlobal+a.house_route)
        send_FTP(a.userFTP, a.password, RutaGlobal, a.house_route, JGBArauca.format(enter))





    def CDT_Kiberly():
        """Funcion de CDT
        
        Keyword arguments: CDT-Dos bases 
        Generar Dataa:

        Return: Retorna el envio de dos archivos planos enviados mediante el FTP
        para arauca actualizar manualmente el years cuando se quiera consultar 
        datos de meses anteriores
        """  
        b = CDTExtract(years,datefin,dateformat,dateinit)
        b.ExecutorSales()


