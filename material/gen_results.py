import os
import sys
import numpy as np

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
    seed1=30
    seed2=30
    maxTime=120
    nExams=15
    overlapProbRange=np.arange(0,1,0.005)

    for overlapProb in overlapProbRange:
            
        runCFile(1,seed1,seed2,nExams,round(overlapProb,4),maxTime,"./results/test3.txt")
        runCFile(2,seed1,seed2,nExams,round(overlapProb,4),maxTime,"./results/test3.txt")

        print("[{}  {}]".format(nExams,round(overlapProb,4)))