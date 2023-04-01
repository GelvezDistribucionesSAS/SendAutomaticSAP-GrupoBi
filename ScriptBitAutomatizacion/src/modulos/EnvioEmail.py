from .VariablesGlobales import *
import os
"""
Envio de error mediante correo para revisar error encontrados
"""
#Envio de correo
import smtplib
from email.message import EmailMessage
def correo():
    remitente = "sistemasgelvez@gmail.com"
    destnario = "sistemas@gelvezdistribuciones.com"
    mensaje = "Error de generación de Archivos de Grupo BIT"
    email = EmailMessage()
    email["From"] = remitente
    email["To"] = destnario
    email["Subject"] = "Correo de error BIT"
    with open(os.path.dirname(os.path.abspath(__file__)) + '\menssage.html','r') as file:
        file_content = file.read()
    with open (RutaGlobal+"LogError.txt",'r') as f:
        file_content_text = f.read() 
    with open (os.path.dirname(os.path.abspath(__file__)) + '\parte2.html','r') as a:
        file_content_2 = a.read()
    email.set_content((file_content+file_content_text+file_content_2),subtype='html')

    smtp = smtplib.SMTP_SSL("smtp.gmail.com")
    smtp.login(remitente,"kgteruttxepuputw")
    smtp.sendmail(remitente,destnario, email.as_string())
    smtp.quit()