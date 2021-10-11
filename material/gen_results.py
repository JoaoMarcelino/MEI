import os
import sys

def main():
    argv = sys.argv[1:]
    seed  = int(argv[0])
    max_time = int(argv[1])
    name = argv[2]
    number_of_datasets = int(argv[3])


    for index in range(number_of_datasets):
        os.system('.\code1 {seed} {max_time} data_sets/gen_{name}_{ds_seed}.txt >> results\code1_gen_{name}'
        .format(seed= seed, max_time= max_time, name= name, ds_seed= index)) 
        
    print("\n")

    for index in range(number_of_datasets):
        os.system('.\code2 {seed} {max_time} data_sets/gen_{name}_{ds_seed}.txt >> results\code2_gen_{name}'
        .format(seed= seed, max_time= max_time, name= name, ds_seed= index)) 



if __name__ == "__main__":
    main()