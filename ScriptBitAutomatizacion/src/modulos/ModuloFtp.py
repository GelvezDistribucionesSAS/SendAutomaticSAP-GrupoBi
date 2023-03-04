import os 
import dotenv

dotenv.load_dotenv()
Hostname = os.getenv('SERVERFTP')

from ftplib import FTP

def send_FTP(userFTP,Password,RutaGlobal,house_route,NameArchivo):
    
        ftp = FTP()
        ftp.connect(Hostname ,21)
        ftp.login(userFTP,Password)
        print(ftp.getwelcome())
        ftp.cwd('/')
        with open(RutaGlobal + house_route + NameArchivo, 'rb') as file:
                ftp.storbinary('STOR '+ NameArchivo , file)
                print('Enviado')
                
        ftp.close()
                
        
