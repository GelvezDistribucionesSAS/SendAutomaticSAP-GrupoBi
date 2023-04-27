from src.modulos.EjecutorPorCasa import GenerateFiles
from src.modulos.Comprimir import Comprimir01, ComprimirNestle
from src.modulos.LogFile import ExecutionHouse , count_elapsed_time
from src.modulos.ModuloFtp import send_FTP
from src.consultas.SalidaData import ReadSQL
from src.modulos.ConvertirData import timed_input, control

@count_elapsed_time
def main():
    
    timed_input()
    ExecutionHouse.bellezacucuta()
    ExecutionHouse.nestlecucuta()
    ExecutionHouse.cucuta_edgewell()
    ExecutionHouse.cucuta_energizer()
    ExecutionHouse.cucuta_HDV()
    ExecutionHouse.cucuta_kimberly_ICH()
    ExecutionHouse.cucuta_kimberly_pañaleras()
    ExecutionHouse.giron_edgwell()
    ExecutionHouse.cucuta_colgate()
    ExecutionHouse.cali_pañ_kimberly()
    ExecutionHouse.Giron_kimberly_ICH()
    ExecutionHouse.giron_eveready()
    ExecutionHouse.giron_nestle()

    #ExecutionHouse.total_gelvez()
    


   
if __name__ == '__main__':
    main()

