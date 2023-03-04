
from datetime import date , timedelta
""" Este modulo contiene todas las rutas de direcctorios junto con las variables que se van a utilizar de manera continua.
-Archivos de extracción
-Nombre de archivos Nuevos
-Ubicaciones individuales de archivos y carpetas.
 """
############# Ruta de Testing ################################################
#Definción de rutas globales
RutaGlobal = 'E:/USER/Downloads/VPN_GELVEZ(1)/venv/ScriptBitAutomatizacion/src/consultas/Salidad/'
#Rutas de consulta sql de SalidaData
rutaBase = 'E:/USER/Downloads/VPN_GELVEZ(1)/venv/ScriptBitAutomatizacion/src/consultas/ConsultasCucuta/'
#RutaBaseGran = 'E:/USER/Downloads/VPN_GELVEZ(1)/venv/ScriptBitAutomatizacion/src/consultas/ConsultasGranDistribuidor/'

#########################################################################################
###########Ruta de productiva ###################
#Definción de rutas globales
#RutaGlobal = "/home/sistemas/share/GrupoBit/"
#Rutas de consulta sql de SalidaData
#rutaBase = "/GrupoBit/GrupoBit/ScriptBitAutomatizacion/src/consultas/ConsultasCucuta/"
#RutaBaseGran = "/GrupoBit/GrupoBit/ScriptBitAutomatizacion/src/consultas/ConsultasGranDistribuidor"
###########################################################################################
#Importación de Diccionarios
fecha = date.today()
dia = fecha.strftime("%d")
 
#Nombre de archivos globales
MUNICIPIOS = 'Municipios.txt'
CLIENTES = 'Clientes.txt'
INVENTARIO = 'Inventario.txt'
SKU = 'sku.txt'
VENDEDORES = 'Vendedores.txt'
VENTAS = 'Ventas.txt'
ARCHIVOS = 'Barrios.txt'
TIPOSNEGOCIOS= 'TipoNegocios.txt'
TOTALES = 'Totales_control.txt'
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
cu_COLGATE_210973 = 'CUC_COLGATE_210973/'
total_GELVEZ = 'GELVEZ_212401/'


#Estructura de nombres de casa para salidad de archivos comprimidos
#################### Cucuta ##########################################
fecha = date.today() - timedelta(days= 1)
BellezaCucuta = 'BELLEZAEXPRESS_210795_' + fecha.strftime("%Y6%m%d")+'.zip'
EdgewellCucuta = 'EDGEWELL_209759_'+fecha.strftime("%Y6%m%d")+'.zip'
EnergeizerCucuta = 'ENERGIZER_210760_'+fecha.strftime("%Y6%m%d")+'.zip'
HdvCucuta = 'HDV_208514_'+fecha.strftime("%Y6%m%d")+'.zip'
KimberlyIchCucuta = 'KIMBERLYICH_208903_'+fecha.strftime("%Y6%m%d")+'.zip'
NestleCucuta = 'NESTLE_212385_'+fecha.strftime("%Y6%m%d")+'.zip'
KimberlyPañCucuta = 'KIMBERLY_209321_'+fecha.strftime("%Y6%m%d")+'.zip'
ColgateCucuta = 'COLGATE_210973_'+fecha.strftime("%Y6%m%d")+'.zip'
###################GranDistribuidor #########################################
edgewellGiron = 'EDGEWELL_211187_'+fecha.strftime("%Y6%m%d")+'.zip'
energeizerGiron = 'EVEREADY_210761_'+fecha.strftime("%Y6%m%d")+'.zip'
kimberlyIchGiron = 'KIMBERLYICH_209968_'+fecha.strftime("%Y6%m%d")+'.zip'
kimberlyPañGiron = 'KIMBERLY_210541_'+fecha.strftime("%Y6%m%d")+'.zip'
nestleGiron = 'NESTLE_211851_'+fecha.strftime("%Y6%m%d")+'.zip'
##################TotalGelvez##############################################
totalGelvez = 'GELVEZ_212401_'+fecha.strftime("%Y6%m%d")+'.zip'
