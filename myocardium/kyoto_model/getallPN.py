import copy
import numpy as np

EntitytypeList = ['System','Process','Variable']
PropertyList = ['','Activity','Value']
loadModel('kuzumoto_et_al_2007_2.5Hz.eml')
time = 5000

def getallEntityList(SYSTEMPATH):
    allEntityList = [SYSTEMPATH,[]]    
    for i in range(len(EntitytypeList)):
        allEntityList[1].append(list(getEntityList(EntitytypeList[i],SYSTEMPATH)))
        for j in range(len(allEntityList[1][i])):
            allEntityList[1][i][j] = EntitytypeList[i] + ':' + SYSTEMPATH + ':' + allEntityList[1][i][j]     
    
    return allEntityList


def treedictionary():
    FAE = getallEntityList('/')
    treedic = []
    treedic.append(FAE)
    SystemList = FAE[1][0]
    for i in range (len(SystemList)):
        SystemList[i] = SystemList[i].replace(':','')
        SystemList[i] = SystemList[i].replace('System','')
        SystemList[i] = SystemList[i] 
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

def makeGXList():
    GXList = [] 
    trredict = treedictionary()[0]
    treevalueList = trredict.values()
    VariableList  = []
    for i in range(len(treevalueList)):
        VariableList.append(treevalueList[i][2])
    for i in range(len(VariableList)):
        for j in range(len(VariableList[i])):
            if len(VariableList[i][j]) > 0:
                if (VariableList[i][j].endswith('GX')) == True:
                    GXList.append(VariableList[i][j])
                else:
                    pass
            else:
                pass


    return GXList

def createallLoger(tree):
    allLoggerList = []
    print PropertyList
    for i in range(len(tree)):
        properties = tree[i]
        for j in range(1,3):
            for k in range(len(properties[1][j])):
                FullPN = properties[1][j][k] + ':' + PropertyList[j] 
                print FullPN
                aLogger = createLoggerStub(FullPN)
                aLogger.create()
                allLoggerList.append(aLogger)
    return allLoggerList

    
tree = treedictionary()[1]
allLoggerList = createallLoger(tree)

run(50)

Data = allLoggerList[0].getData()
Data1 = np.matrix(Data)
Data1 = Data1[:,0]
Data1 = Data1.tolist()
print Data1
rabelrows = ['time']
for i in range(len(allLoggerList)):
    Data2 = allLoggerList[i].getData()
    rabel = allLoggerList[i].getName()
    if len(Data2) > 1:
        rabelrows.append(rabel)
    else:
        pass
    for j in range(len(Data1)):
        if len(Data2) > time * 100 and len(Data2) < time * 200:
            Data1[j].append(Data2[j][1])

        elif len(Data2) > time * 200:        
            Data1[j].append(Data2[2*j][1])
        
        else:
            pass

Data1.insert(0,rabelrows)




print len(Data1[0])
print tree

saveModel('sample.eml')


