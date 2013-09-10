import os 
import csv 
import numpy as np 

class Main:
    def __init__( self ):
        self.MODEL_FILE     = 'RS.eml'
        self.LoggerList     = [ "Variable:/CELL:V:Value","Variable:/CELL:u:Value" ]  
        self.re             = 10 
        self.runtime        = 100 
        self.EntitytypeList = [ 'System','Process','Variable'] 
    
    def loadModel( self ):
        loadModel( 'self.MODEL_FILE' )

    def run( self ):
        run( self.runtime )

    def createLoggers( self )
        for i in range( len( self.LoggerList ) ):
            self.LoggerList[i] = createLoggerStub(LoggerList[i])
            LoggerList[i].create() 


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
         a   for i in range(len(SystemList)): 
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

        for i in range(len(loggerlist) - 1): 
            Next_Data  = self.LoggerList[i + 1].getData()
            
            for j in range(len(Data)):
                Data[j].append( Next_Data[j][1] )
        
        return dict( zip( time,Data ) )


class Analysis:
    def __init__( self,dict_data ):
        self.dict_data = dict_data
        self.times     = dict_data.keys().sort()
        self.endtime   = self.times[ len( self.times ) - 1 ] 
        self.Range     = pow(10,-3) 
        self.result    = 0

    def analysis1( self ):
        i = 0
        time = self.times[i]
        while time < self.endtime * 1.0 / 2: 
            time = self.times[i]
            gap  = [ abs( self.dict_data[ self.endtime ][i] - self.dict_data[ time ][i] ) for i in raange( len(a) ) ]
            judge  = [ 1 for i in range(len(gap))  if gap[i] < self.dict_data[ endtime ][i] * self.Range ]

            if reduce(lambda a,b: a+b,judge)  == len(gap):
                self.result = ( self.endtime - time ) * 1.0 / 2 
                print self.endtime / 2
                break
            else:
                self.result = 'contiue'
                pass
        return self.result



Main = Main()
Main.loadModel()
Main.createLoggers()

for i in range( 100 )
    Main.run()
    Data = Main.join()
    Analysis = Analysis( Data )
    result = Analysis.analysis1()
    if result == 'continue':
        pass 
    else:
        print result
        break  






        

                                          


                             
