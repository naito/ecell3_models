from ecell.ECDDataFile import * 
import random 
import os 
import shutil 
import csv
import copy
MODEL_FILE = 'kuzumoto_et_al_2007_2.5Hz.eml'
ESS_FILE = 'vicinitysession.py'
roopCocurrency = 2
#setEnvironment('SGE')
#setConcurrency(12)
setTmpDirRemovable(False)
class Population: 
    def __init__(self):
        self.Min = 0
        self.Max = 0
        self.currentnumber = 0
        self.finishnumber = 0
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
        while i < roopCocurrency and self.finishnumber < 46:
            for self.GX in xrange(self.Min,self.Max + 2):
                indivisual = Indivisual(self.currentnumber,self.GX)
                indivisual.setJobparamater()
                indivisual.makeJobID(self.SofileList)
                self.IndivisualList.append(indivisual)
                self.JobIDList.append(indivisual.aJobID)
                self.finishnumber += 1
                print self.finishnumber
            self.currentnumber += 1
            i += 1
        run()
            
    def setJobList(self):
        i = 0
        for aJobID in self.JobIDList:
            self.IndivisualList[i].getJob()
            self.JobList.append(self.IndivisualList[i].aJob)
            self.GXPNList.append(self.JobList[i][2])
            i += 1
        self.end = self.JobList[i-1][1]

    def main(self):
        while self.end == "continue":
            self.makeSofileList()
            self.makeIndivisual()
            self.setJobList()
            self.IndivisualList = []
            self.JobIDList = []
            self.JobList = []



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
print 'Finish'
work = os.listdir('./tmp')
workcopy = copy.copy(work)
for i in range(len(workcopy)):
    if workcopy[i] == '.DS_Store':
        work.remove('.DS_Store')
        
for i in range(46):
    os.rename('./tmp/' + work[0] + '/' + str(i+1),'./tmp/' + work[0] + '/' + p.GXPNList[i])
shutil.move('./tmp/' + work[0],'./')

