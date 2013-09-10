from ecell.ECDDataFile import *
import csv 
import os
import numpy as np

MODEL_FILE = 'kuzumoto_et_al_2007_2.5Hz.eml'
LoggerList = ["Variable:/CELL/MEMBRANE:Vm:Value","Variable:/CELL/CYTOPLASM:K:MolarConc","Variable:/CELL/CYTOPLASM:Na:MolarConc","Variable:/CELL/CYTOPLASM:Ca:MolarConc"]
re         = 10 
first_time = 5
run_time   = 400 

'''
Get FullPN of all Value and Activity for creting logger stub of all. 
This function  is called with a Systempath as argument.
And it returns Systempath of System, Variable FullPN of Variable and Process which are descendants of arguments.
'''

def getallEntityList(SYSTEMPATH):
    EntitytypeList = ['System','Process','Variable']
    allEntityList = [SYSTEMPATH,[]]    
    for i in range(len(EntitytypeList)):
        allEntityList[1].append(list(getEntityList(EntitytypeList[i],SYSTEMPATH)))
        for j in range(len(allEntityList[1][i])):
            allEntityList[1][i][j] = EntitytypeList[i] + ':' + SYSTEMPATH + ':' + allEntityList[1][i][j]     
    return allEntityList

'''
This function don't take arguments. It returns dictionary.it has Systempath as key.
So if you type any Systempath, you could get  Systempath of System, Variable FullPN of Variable and Process which are descendants of the key.
'''

def treedictionary(SYSTEMPATH):
    FAE = getallEntityList(SYSTEMPATH)
    treedic = []
    treedic.append(FAE)
    SystemList = FAE[1][0]
    for i in range (len(SystemList)):
        SystemList[i] = SystemList[i].replace(':','')
        SystemList[i] = SystemList[i].replace('System','')
    while len(SystemList) > 0:
        Next_SystemList = []
        for i in range(len(SystemList)): 
            AE = getallEntityList(SystemList[i])
            treedic.append(AE)
            for j in range(len(AE[1][0])):
                Next_SystemList.append(AE[1][0][j])


        for i in range(len(Next_SystemList)):
            Next_SystemList[i] = Next_SystemList[i].split(':')
            Next_SystemList[i] = Next_SystemList[i][1] + '/' + Next_SystemList[i][2]

        SystemList = Next_SystemList
    
    return dict(treedic),treedic    

def join(loggerlist):
    Datalist  = []
    Data      = loggerlist[0].getData()
    Data      = np.matrix(Data)
    time      = Data[:,0]
    Data      = Data[:,1]
    Data      = Data.tolist()
    time      = time.tolist()
    t_list    = []
    for item in time:
        for t in item:
            t_list.append(t)

    time = t_list

    for i in range(len(loggerlist) - 1): 
        Next_Data  = LoggerList[i + 1].getData()
        
        for j in range(len(Data)):
            Data[j].append(Next_Data[j][1])
    
    return dict(zip(time,Data)) 



#def analysis(Data):
#    end_time = Data[len(Data)][0] 
#    for i in range(len(Data)):
        
        
loadModel( MODEL_FILE )
for i in range(len(LoggerList)):
    LoggerList[i] = createLoggerStub(LoggerList[i])
    LoggerList[i].create()

run(first_time)

print join(LoggerList)

#for i in range(re):
#    run(run_time)
#    Log_Data = join(LoggerList)
    





    




    
