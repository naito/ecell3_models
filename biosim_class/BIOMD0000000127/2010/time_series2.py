import os 
import csv 
import numpy as np 

class Main:
    def __init__( self ):
        self.MODEL_FILE     = 'RS.eml'
        self.LoggerList     = [ "Variable:/CELL:v:Value","Variable:/CELL:u:Value" ]  
        self.re             = 10 
        self.runtime        = 100 
        self.EntitytypeList = [ 'System','Process','Variable'] 
    
    def loadModel( self ):
        loadModel( self.MODEL_FILE )

    def run( self ):
        run( self.runtime )

    def createLoggers( self ):
        for i in range( len( self.LoggerList ) ):
            self.LoggerList[i] = createLoggerStub( self.LoggerList[i] )
            self.LoggerList[i].create() 


    def getallEntityList( self,SYSTEMPATH ):
        allEntityList = [ SYSTEMPATH,[] ]    
        for i in range( len ( self.EntitytypeList ) ):
            allEntityList[1].append( list( getEntityList( self.EntitytypeList[i],SYSTEMPATH ) ) )
            for j in range(len(allEntityList[1][i])):
                allEntityList[1][i][j] = self.EntitytypeList[i] + ':' + SYSTEMPATH + ':' + allEntityList[1][i][j]     
        
        return allEntityList 


    def treedictionary( self,SYSTEMPATH ):       
        FAE = getallEntityList( SYSTEMPATH )
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


    def join( self ):           
        Datalist  = []
        Data      = self.LoggerList[0].getData()
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

        for i in range(len(self.LoggerList) - 1): 
            Next_Data  = self.LoggerList[i + 1].getData()
            
            for j in range(len(Data)):
                Data[j].append( Next_Data[j][1] )
        
        return dict( zip( time,Data ) ),time


class Analysis:
    def __init__( self ):
        self.dict_data = None
        self.times     = None
        self.starttime = 0
        self.endtime   = None
        self.Range     = pow(10,-3)
        self.result    = 0
        self.num       = 0

    def Set( self ):     
        self.endtime   = self.times[ len( self.times ) - 1 ] 

    def analysis1( self ):
        self.num += 1
        time = self.times[ self.starttime ] 
        print time
        f = open('gap.txt','a+')      
        gap = abs( self.dict_data[ self.endtime ][0] - self.dict_data[ time ][0] ) 
        while time < self.endtime * 1.0 / ( self.num % 2 + 1 ): 
            self.starttime += 1
            time = self.times[ self.starttime ]
            gap = abs( self.dict_data[ self.endtime ][0] - self.dict_data[ time ][0] )      
            if gap < self.Range:
                gaps   = [ abs( self.dict_data[ self.endtime ][j] - self.dict_data[ time ][j] ) for j in range( len( self.dict_data[ time ] ) ) ]
                judge  = [ 1 for j in range(len(gaps))  if gaps[j] <  self.Range ]

                print >>f, str(gaps[0]) +  ',' + str(gaps[1]) + ',' + '\n' + str(len(judge)) + '\n'

                if len(judge) > 0 and reduce(lambda a,b: a+b,judge)  == len(gaps):
                    self.result = ( self.endtime - time )
                    break  

                else:
                    self.result = 'continue'


            else:
                self.result = 'continue'
                pass

        
        return self.result,time,self.endtime



Main = Main()
Main.loadModel()
Main.createLoggers()
Analysis = Analysis( )

for i in range( 100 ):
    Main.run()
    Data = Main.join()
    Analysis.dict_data = Data[0]
    Analysis.times = Data[1]
    Analysis.Set()
    result = Analysis.analysis1()
    if result[0] == 'continue': 
        print i
        Analysis.num += 1
        Analysis.starttime = 0
    else:
        print result[0]
        Analysis.starttime += 10
        result = Analysis.analysis1()
        if result[0] == 'continue':
            Analysis.starttime = 0
        
        else:
            print result[0] 
            break


        




        

                                          


                             
