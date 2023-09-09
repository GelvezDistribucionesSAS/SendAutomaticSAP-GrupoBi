from src.modulos.LogFile import ExecutionHouse , count_elapsed_time
from src.modulos.ConvertirData import timed_input

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
    ExecutionHouse.giron_nestleCandelaria()
    ExecutionHouse.brisan_Arauca()
    ExecutionHouse.total_gelvez()
    ExecutionHouse.CDT_Kiberly()
if __name__ == '__main__':
    main()

