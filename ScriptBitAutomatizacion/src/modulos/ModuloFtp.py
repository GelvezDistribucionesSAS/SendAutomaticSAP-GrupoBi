import os 
import dotenv

dotenv.load_dotenv()
Hostname = os.getenv('SERVERFTP')

from ftplib import FTP

def send_FTP(userFTP,Password,RutaGlobal,house_route,NameArchivo):
        """ 
        Funcion que se encarga de tomar los archivos generados comprimidos  para que sean entregados
        a cada uno  de los cansilleros entregados por el proveedor. 
        """
        ftp = FTP()
        ftp.connect(Hostname ,21)
        ftp.login(userFTP,Password)
        print(ftp.getwelcome())
        ftp.cwd('/')
        with open(RutaGlobal + house_route + NameArchivo, 'rb') as file:
                ftp.storbinary('STOR '+ NameArchivo , file)
                print('Enviado')
                
        ftp.close()

def sendFTPCDT(host,userFTP,Password,RutaGlobal,house_route,NameArchivo):
        """ 
        Funcion que se encarga de tomar los archivos de ventas e inventarios y cargarlos a ftp
        CDT mediante la inclución de cada uno de los archivos. 
        """
        ftp = FTP()
        ftp.connect(host ,21)
        ftp.login(userFTP,Password)
        print(ftp.getwelcome())
        ftp.cwd('/')
        with open(RutaGlobal + house_route + NameArchivo, 'rb') as file:
                ftp.storbinary('STOR '+ NameArchivo , file)
                print('Enviado')
                
        ftp.close()
                
        
