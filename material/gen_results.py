import os
import sys
from typing import IO
import numpy as np
from random import randint

def runCFile(codeFile,seed1,seed2,nExams,overlapProb,maxTime,targetFile):

    generatorFileName="data_sets/gen_{}_{}_{}.txt".format(nExams,overlapProb,seed2)
    
    
    if os.path.exists(generatorFileName) is False:
        os.system("python3 gen.py {} {} {} {}".format(nExams,overlapProb,seed2,generatorFileName))
    
    if codeFile==1:      
        os.system("( echo -n \"{code} {seed1} {seed2} {nExams} {overlapProb} {maxTime} \" ; ./code1 {seed1} {maxTime} {generatorFileName} ) >> {targetFile}"
        .format(code=codeFile,seed1=seed1,seed2=seed2,nExams=nExams,overlapProb=overlapProb,maxTime=maxTime,generatorFileName=generatorFileName,targetFile=targetFile))
    elif codeFile==2:   
        os.system("( echo -n \"{code} {seed1} {seed2} {nExams} {overlapProb} {maxTime} \" ; ./code2 {seed1} {maxTime} {generatorFileName} ) >> {targetFile}"
        .format(code=codeFile,seed1=seed1,seed2=seed2,nExams=nExams,overlapProb=overlapProb,maxTime=maxTime,generatorFileName=generatorFileName,targetFile=targetFile))
    else:
        raise Exception

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
    seedMax = 3000000
    maxTime = 180
    nExams = [5, 10, 15, 20]
    overlapProb=[0.10, 0.30, 0.5, 0.7, 0.9]

    file = "./results_2/test3.txt"
 
    os.system("echo \"codigo seed1 seed2 nExams overlapProb maxTime minSlots time\" >> {file}".format(file = file))
    i = 0
    for overlap in overlapProb:
        for exams in nExams:
            for j in range(25):

                runCFile(1, i  , i + 600,exams ,round(overlap,4) ,maxTime, file)
                runCFile(2, i + 1200, i + 1800,exams ,round(overlap,4) ,maxTime, file)

                i += 1
                print("[{}  {}]".format(exams,round(overlap,4)))
