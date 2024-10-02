from src.modulos.LogFile import ExecutionHouse , count_elapsed_time
from src.modulos.ConvertirData import timed_input
from src.modulos.Conexion import conexion
@count_elapsed_time
def main():

    timed_input()
    #ExecutionHouse.bellezacucuta()
    #ExecutionHouse.nestlecucuta()
    #ExecutionHouse.nestleocana()
    #ExecutionHouse.cucuta_edgewell()
    #ExecutionHouse.cucuta_energizer()
    #ExecutionHouse.cucuta_HDV()
    #ExecutionHouse.cucuta_unilever()
    #ExecutionHouse.giron_edgwell()
    ExecutionHouse.cucuta_colgate()
    #ExecutionHouse.jgb_cucuta()
    #ExecutionHouse.jgb_giron()
    ExecutionHouse.jgb_arauca()
    #ExecutionHouse.giron_eveready()
    #ExecutionHouse.giron_nestle()
    #ExecutionHouse.giron_nestleCandelaria()
    #ExecutionHouse.giron_unilever()
    ExecutionHouse.brisan_Arauca()
    ExecutionHouse.unilever_Arauca()
    #ExecutionHouse.total_gelvez()
    #ExecutionHouse.CDT_Kiberly()
    #ExecutionHouse.cali_pañ_kimberly()
    #ExecutionHouse.Giron_kimberly_ICH()
    #ExecutionHouse.cucuta_kimberly_ICH()
    #ExecutionHouse.cucuta_kimberly_pañaleras()
if __name__ == '__main__':
    main()

