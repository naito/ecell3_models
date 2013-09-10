from ecell.ECDDataFile import *
import os 
import shutil
import csv
import copy
import numpy as np
import os.path

MODEL_FILE = 'kuzumoto_et_al_2007_2.5Hz.eml'
VALUE_OF_GX = 1
currentnumber = 0
theSimulator.setDMSearchPath('.:../../../:/home/ecell3_models/myocardium/kyoto_model')
RECORDING_TIME = 6
RUN_TIME = 6
EntitytypeList = ['System','Process','Variable']
PropertyList = ['','Activity','Value']
loadModel(MODEL_FILE) 

'''
Get FullPN of all Value and Activity for creting logger stub of all. 
This function  is called with a Systempath as argument.
And it returns Systempath of System, Variable FullPN of Variable and Process which are descendants of arguments.
'''

def getallEntityList(SYSTEMPATH):
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

'''
This function take dictionary {} as argument and return list [] which has FullPN of GX as elements.
GX is Expression level of chanel, pump and exchanger ETC relative to ordinary condition.
'''

def makeGXList(treedict):
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

'''
This function take list [] that is return value of treedictionary(). 
And it return list that has Loggerstubs of all Activity and Value in this model as elements.
'''
def createallLoger(tree):
    allLoggerList = []
    for i in range(len(tree)):
        properties = tree[i]
        for j in range(1,3):
            for k in range(len(properties[1][j])):
                FullPN = properties[1][j][k] + ':' + PropertyList[j] 
                aLogger = createLoggerStub(FullPN)
                aLogger.create()
                aLogger.setLoggerPolicy([10,0.1,1,100000])
                allLoggerList.append(aLogger)
    return allLoggerList

'''
This function cannot active. I want to save all Logger data to one ecd file, but ECDDataFile.save()
not active. So I wonder if ECDDataFile.save() can't take array which has 6 elements or more?  
'''

def saveECD(LoggerList,FullPN):
    Data      = LoggerList[0].getData()
    Data      = np.matrix(Data)
    Data      = Data[:,0]
    Data      = Data.tolist()
    rabelrows = ['time']
    for i in range(len(LoggerList)):
        Next_Data  = LoggerList[i].getData()
        rabel      = LoggerList[i].getName()
        if len(Next_Data) > 1:
            rabelrows.append(rabel)

        else:
            pass

        for j in range(len(Data)):
            if len(Next_Data) > RECORDING_TIME * 200:
                Data[j].append(Next_Data[2 * j][1])
            elif len(Next_Data) > RECORDING_TIME * 100:
                Data[j].append(Next_Data[j][1])

            else:
                pass

    Data.insert(0,rabelrows)
    Data = np.array(Data)
    ECDFile = ECDDataFile(Data)
    ECDFile.setDataName(VmLogger.getName())
    ECDFile.setNote(FullPN + 'is' + str(VALUE_OF_GX))
    FullPN   = FullPN.replace(':','_')
    FullPN   = FullPN.replace('/','_')
    filename = FullPN + str(VALUE_OF_GX) + '.ecd'
    ECDFile.save(filename)
     
'''
This function made in place of former function.
It takes list[] and str'' as arguments and save Logger data which list[] has to one csv file.
'''

def saveCSV(LoggerList,FullPN):
    Data      = LoggerList[0].getData()
    Data      = np.matrix(Data)
    Data      = Data[:,0]
    Data      = Data.tolist()
    rabelrows = ['time']
    shortrabelrows = ['time']
    for i in range(len(LoggerList)):
        Next_Data  = LoggerList[i].getData()
        rabel      = LoggerList[i].getName()
        if rabel == 'Variable:/CELL/MEMBRANE:Vm:Value':
            #It is temporary repair.
            #Variable:/CELL/MEMBRANE:Vm:Value Logger is maked when simulation started.
            #So the log we want to take is between 800 and 1200.Yet if I get log of this as with any Logger, We would take log between 0 and 400. 
            pass

            
        elif len(Next_Data) > RECORDING_TIME * 18:
            for j in range(len(Data)):
                Data[j].append(Next_Data[2*j][1])
            rabel = rabel.split(':')
            path  = rabel[0][0] + ':' + rabel[1] + ':' + rabel[2]
            rabel[1] = rabel[1].split('/')
            rabel[1][-1] = rabel[1][-1].replace(':','')
            shortrabel =rabel[0][0] + '_' + rabel[1][-1] +':' + rabel[2]
            shortrabelrows.append(shortrabel)

        elif len(Next_Data) > RECORDING_TIME * 9:


            for j in range(len(Data)):
                Data[j].append(Next_Data[j][1])
            rabel = rabel.split(':')
            path  = rabel[0][0] + ':' + rabel[1] + ':' + rabel[2]
            rabel[1] = rabel[1].split('/')
            rabel[1][-1] = rabel[1][-1].replace(':','')
            shortrabel = rabel[0][0] + '_' + rabel[1][-1] +':' + rabel[2]
            shortrabelrows.append(shortrabel)
        else:
            pass
    Data.insert(0,shortrabelrows)
    FullPN   = FullPN.replace(':','_')
    FullPN   = FullPN.replace('/','|')
    filename = FullPN + '_' +  str(VALUE_OF_GX) + '.csv'
    csvfile  = open(filename,'w')
    writer   = csv.writer(csvfile)
    writer.writerows(Data)
    csvfile.close()

#main 
tree = treedictionary()
GXList    = makeGXList(tree[0]) 

#Endnumber is very important number. 
#If currentnumber became endnumber, ecell3-session-manager would be over.
endnumber = len(GXList) 

#FullPN_GX is an FullPN of GX which is changed value according to VALUE_OF_GX and currentnumber.
FullPN_GX = GXList[currentnumber] 

#create EntityStub.
GXEntity  = createEntityStub(FullPN_GX)

#substitute VALUE_OF_GX for value of FullPN_GX.
GXEntity.setProperty('Value',VALUE_OF_GX)

#To replace characters that cannot be used in file name with other characters. 
FullPN_GX       = FullPN_GX.replace(':','_')
FullPN_GX       = FullPN_GX.replace('/','|')

#setting for pre run.
AmplitudeEntity = createEntityStub('Process:/Pipette:I')
AmplitudeEntity.setProperty('amplitude',0)
VmLogger = createLoggerStub('Variable:/CELL/MEMBRANE:Vm:Value')
VmLogger.create()
VmLogger.setLoggerPolicy([1,1.00,1,1000000])
#pre run
run(RUN_TIME)

#setting for run under stimulation.
AmplitudeEntity.setProperty('amplitude',-8000)

#run 
run(RUN_TIME)
allLoggerList = createallLoger(tree[1])

#run for recording simulation log of all variable in this model.
VmLogger.setLoggerPolicy([1,0.1,1,1000000])
run(RECORDING_TIME)

#save simulation log of membrane potential in files as csv and ecd.
pretimecourse     = VmLogger.getData()
precsvfile        = open('Vm' + '_' + FullPN_GX + '_' + str(VALUE_OF_GX) + '.csv','w')
writer            = csv.writer(precsvfile)
pretimecourse_csv = np.matrix(pretimecourse)
pretimecourse_csv = pretimecourse_csv.tolist()
name = ['time','Vm']
pretimecourse_csv.insert(0,['time','Vm'])
writer.writerows(pretimecourse_csv)
pretimecourse = ECDDataFile(pretimecourse)
pretimecourse.setDataName(VmLogger.getName()) 
pretimecourse.setNote(VmLogger.getName())
pretimecourse.save('Vm' + '_' + FullPN_GX + '_' +  str(VALUE_OF_GX) + '.ecd')

#save simulation log of all variable except for membrane potential in a file as csv.
saveCSV(allLoggerList,FullPN_GX)

#
print currentnumber
if currentnumber == endnumber - 1:
    print "end" 

else:
    print "continue"

print FullPN_GX + '_' +  str(VALUE_OF_GX)
print endnumber


