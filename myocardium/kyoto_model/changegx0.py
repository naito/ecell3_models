from ecell.ECDDataFile import * 
import random 
import os 
import shutil 
import csv

MODEL_FILE = 'kuzumoto_et_al_2007_2.5Hz.eml'
ESS_FILE = 'runsession.py'
roopCocurrency = 2
#setEnvironment('SGE')
#setConcurrency(12)
setTmpDirRemovable('False')
class Population: 
    def __init__(self):
        self.Min = -5
        self.Max = 5
        self.currentnumber = 0
        self.IndivisualList = []
        self.JobIDList = []
        self.JobList = []
        self.GX  = 0
        self.SOfile = None
        self.end = "continue"
        self.SofileList = []
        self.GXPNList = [] 
   
    def makeSofileList(self):
        FileList = os.listdir('./')
        for i in range(len(FileList)):
            if FileList[i].endswith('so') == True:
                self.SofileList.append(FileList[i])
            else:
                pass

    def makeIndivisual(self):
        i = 0
        j = 0
        os.mkdir(/home/t12870hm/vicinity/ + str(currentnumber))
        while i < roopCocurrency:
            for self.GX in xrange(self.Min,self.Max + 2):
                indivisual = Indivisual(self.currentnumber,self.GX)
                indivisual.setJobparamater()
                indivisual.makeJobID(self.SofileList)
                self.IndivisualList.append(indivisual)
                self.JobIDList.append(indivisual.aJobID)
            self.currentnumber += 1
            i += 1
            j += self.GX
            print i
            if j == 132:
                break
        run()
            
    def setJobList(self):
        i = 0
        for aJobID in self.JobIDList:
            self.IndivisualList[i].getJob()
            self.JobList.append(self.IndivisualList[i].aJob)
            i += 1
        self.currentnumber = int(self.JobList[0][0])
        self.end = self.JobList[0][1]
        self.GXList.append(self.JobList[0][2])

    def main(self):
        os.mkdir('/home/t12870hm/vicinity')
        while self.end == "continue":
            self.makeSofileList()
            self.makeIndivisual()
            self.setJobList()
            self.IndivisualList = []
            self.JobIDList = []
            self.JobList = []
        for i in range(self.currentnumber):
            os.rename('/home/t12870hm/vicinity/' + str(i),'/home/t12870hm/vicinity/' + self.GXList[i])
        print "Finsh"



class Indivisual:
    def __init__(self,currentnumber,GX):
        self.VALUE_0F_GX = GX
        self.aJobparamater = None 
        self.aJobID = None 
        self.aJob = None
        self.currentnumber = currentnumber
           
    def setJobparamater(self):
        if self.VALUE_0F_GX == 6:
            self.VALUE_0F_GX = 0
        else:
            self.VALUE_0F_GX = pow(2,self.VALUE_0F_GX)

        self.aJobparamater = {'MODEL_FILE':MODEL_FILE,'VALUE_OF_GX':self.VALUE_0F_GX,'currentnumber':self.currentnumber}

    def makeJobID(self,SOfile):
        SOfile.append(MODEL_FILE)
        self.aJobID = registerEcellSession( ESS_FILE,self.aJobparamater,SOfile ) 

    def getJob(self):
        self.aJob = getStdout(self.aJobID)
        self.aJob = self.aJob.split('\n')
        del self.aJob[len(self.aJob)-1]


p = Population()
p.main()

