
from datetime import date , timedelta, datetime
import selectors, sys

""" Este modulo contiene todas las rutas de direcctorios junto con las variables que se van a utilizar de manera continua.
-Archivos de extracción
-Nombre de archivos Nuevos
-Ubicaciones individuales de archivos y carpetas.
 """
############# Ruta de Testing ################################################
#Definción de rutas globales
##RutaGlobal = '/home/sistemas/Proyectos/SendAutomaticSAP-GrupoBi/ScriptBitAutomatizacion/salida/'
##rutaArauca ="/home/sistemas/Proyectos/SendAutomaticSAP-GrupoBi/ScriptBitAutomatizacion/src/consultas/ConsultasArauca/"
##rutaBase = "/home/sistemas/Proyectos/SendAutomaticSAP-GrupoBi/ScriptBitAutomatizacion/src/consultas/ConsultasCucuta/"

#########################################################################################
###########Ruta de productiva ###################
#Definción de rutas globales
RutaGlobal = "/home/sistemas/share/GrupoBit/"
#Rutas de consulta sql de SalidaData
rutaBase ="/proyectoBit/SendAutomaticSAP-GrupoBi/ScriptBitAutomatizacion/src/consultas/ConsultasCucuta/"
rutaArauca ="/proyectoBit/SendAutomaticSAP-GrupoBi/ScriptBitAutomatizacion/src/consultas/ConsultasArauca/"
#RutaBaseGran = "/GrupoBit/GrupoBit/ScriptBitAutomatizacion/src/consultas/ConsultasGranDistribuidor"
###########################################################################################
#Importación de Diccionarios
fecha = date.today() 
dia = fecha.strftime("%d")
 
#Nombre de archivos globales
MUNICIPIOS = 'Municipios.txt'
CLIENTES = 'Cliente.txt'
INVENTARIO = 'Inventario.txt'
SKU = 'sku.txt'
VENDEDORES = 'Vendedores.txt'
VENTAS = 'Ventas.txt'
ARCHIVOS = 'Barrios.txt'
TIPOSNEGOCIOS= 'TipoNegocio.txt'
TOTALES = 'Totales_Control.txt'
BARRIOS = 'Barrios.txt'
SELLIN = 'SellIn.txt'
#Control data para Generar comprimidos
data = [CLIENTES,INVENTARIO,MUNICIPIOS,SKU,TIPOSNEGOCIOS,TOTALES,VENDEDORES,VENTAS]
dataNestle = [CLIENTES,INVENTARIO,MUNICIPIOS,SKU,TIPOSNEGOCIOS,TOTALES,VENDEDORES,VENTAS,BARRIOS]
dataTotal = [CLIENTES,INVENTARIO,MUNICIPIOS,SKU,TIPOSNEGOCIOS,TOTALES,VENDEDORES,VENTAS,BARRIOS, SELLIN]
#Nombre Globales Unicaciones
Belleza = "BELLEZAEXPRESS_210795/"
CAL_PAÑ_KIMBERLY_210541 = "CAL_PAÑ_KIMBERLY_210541/"
cu_EDGEWELL_209759 = "CUC_EDGEWELL_209759/"
cu_ENERGIZER_210760 = 'CUC_ENERGIZER_210760/'
cu_HDV_208514 = 'CUC_HDV_208514/'
cu_KIMBERLY_208903 = 'CUC_KIMBERLY_208903/'
cu_NESTLE_212385 = 'CUC_NESTLE_212385/'
cu_PAÑ_KIMBERLY_209321 = 'CUC_PAÑ_KIMBERLY_209321/'
gir_EDGWELL_211187 = 'GIR_EDGWELL_211187/'
gir_EVEREADY_210761 = 'GIR_EVEREADY_210761/'
gir_ICH_KIMBERLY_209968 = 'GIR_ICH_KIMBERLY_209968/'
gir_NESTLE_211851 = 'GIR_NESTLE_211851/'
gir_NESTLE_212587 = 'GIR_NESTLE_212587/'
cu_COLGATE_210973 = 'CUC_COLGATE_210973/'
total_GELVEZ = 'GELVEZ_212401/'
Ara_BRINSA= 'BRINSA_213173/'


#

#Entrada de movimiento de fecha 
VarDateSQL= " ADD_DAYS(LAST_DAY(ADD_MONTHS(CURRENT_DATE, -{})),+1) AND ADD_DAYS(TO_VARCHAR(CURRENT_DATE,'YYYYMMDD'), -1 )"
Date  = date.today() - timedelta(days= 1)
mesDate = Date.month
#Define el inicio del mes
def month_start_control():
    x = datetime.now()
    if x.strftime("%d") == "01":
        return 2
    else:
        return 1
      
def timed_input(prompt="", timeout=5) -> int:
    sel = selectors.DefaultSelector()
    sel.register(sys.stdin, selectors.EVENT_READ, input)

    respuesta = None
    print(prompt, end="")
    events = sel.select(timeout=timeout)
    try:
        if events:
            respuesta = input()
        else:
            respuesta = 0
            return respuesta
    except EOFError :
        return 0
    


def control():
    VarFormat = ''
    years = ''
    mes = ''
    if timed_input() == 0:
        oneDay = timedelta(days=1)
        VarFormat = VarDateSQL.format(month_start_control())
        enter = str(Date.strftime("%Y6%m%d"))
        mes = str(Date.strftime("%Y"))
        years = str(Date.strftime("%m"))
        InvetoryValidor = "CURRENT_DATE,-{0}".format(month_start_control())
        datefin = datetime.now()- oneDay
        print(enter)
        print(datefin)
        return VarFormat, InvetoryValidor, enter , mes, years, datefin.strftime("%Y%m%d")
    else: 
        dateinit = input('Fecha incial: ')
        datefin = input('Fecha Final: ')
        VarFormat = "'{}' AND '{}'".format(dateinit, datefin )
        enter = datefin[0:4]+'6'+datefin[4:8]
        InvetoryValidor = "CURRENT_DATE,-{0}".format(1)
        return VarFormat, InvetoryValidor, enter, mes, years, datefin
#Estructura de nombres de casa para salidad de archivos comprimidos
#################### Cucuta ##########################################

fecha = Date.strftime("%Y6%m%d")

BellezaCucuta = 'BELLEZAEXPRESS_210795_{}.zip'
EdgewellCucuta = 'EDGEWELL_209759_{}.zip'
EnergeizerCucuta = 'ENERGIZER_210760_{}.zip'
HdvCucuta = 'HDV_208514_{}.zip'
KimberlyIchCucuta = 'KIMBERLY_208903_{}.zip'
NestleCucuta = 'NESTLE_212385_{}.zip'
KimberlyPañCucuta = 'KIMBERLY_209321_{}.zip'
ColgateCucuta = 'COLGATE_210973_{}.zip'
###################GranDistribuidor #########################################
edgewellGiron = 'EDGEWELL_211187_{}.zip'
energeizerGiron = 'ENERGIZER_210761_{}.zip'
kimberlyIchGiron = 'KIMBERLY_209968_{}.zip'
kimberlyPañGiron = 'KIMBERLY_210541_{}.zip'
nestleGiron = 'NESTLE_211851_{}.zip'
nestleCaliEje = 'NESTLE_212587_{}.zip'
##################TotalGelvez##############################################
totalGelvez = 'GELVEZ_212401_{}.zip'

#######################ARAUCA############################################
brinsaArauca = 'BRINSA_213173_{}.zip'
       