import os
import sys

def main():
    argv = sys.argv[1:]
    exams_number = int(argv[0])
    probability = float(argv[1])
    number_of_datasets = int(argv[2])

    #os.mkdir('data_sets/{gen}'.format(gen= gen))

    for i in range(number_of_datasets):
        os.system('python3 gen.py {exams_number} {probability} {seed} data_sets/gen_{exams_number}_{probability}_{seed}.txt'
        .format(exams_number= exams_number,probability= probability, seed= i)) 


if __name__ == "__main__":
    main