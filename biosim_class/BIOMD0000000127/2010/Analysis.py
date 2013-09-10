import os 
import csv 
import numpy as np    


class Main:
    def __init__( self ):
        self.MODEL_FILE     = 'RS.eml'
        self.LoggerList     = [ "Variable:/CELL:v:Value","Variable:/CELL:u:Value" ]  
        self.runtime        = 200 
        self.EntitytypeList = [ 'System','Process','Variable'] 
        self.stepInterval   = None
        self.re = 10 
        
    def loadModel( self ):
        loadModel( self.MODEL_FILE )

    def getStepInterval( self ):
        currenttime1 = getCurrentTime()
        step(1)
        currenttime2 = getCurrentTime()
        self.stepInterval = currenttime2 - currenttime1

        return self.stepInterval


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
        self.endtime   = None
        self.Range     = 0.001
        self.gapdict    = None
        self.judge     = 'failure'
   
    def Set( self ):
        self.times.reverse()
        self.endtime  = self.times[ 0 ]

    def analysis1( self ):
        gaplist    = [ [ self.times[i],abs( abs( self.dict_data[ self.times[i] ][0] * 1.0 / self.dict_data[ self.endtime ][0] ) - 1 ) ] for i in xrange( 1,len( self.times ) )  if abs(abs( self.dict_data[ self.times[i] ][0] * 1.0 / self.dict_data[ self.endtime ][0] ) - 1) < self.Range ]
        self.times = [ gaplist[i][0] for i in range( len( gaplist ) ) ]
        gapslist   = [ [ abs( abs( self.dict_data[ self.endtime ][i] * 1.0 / self.dict_data[ time ][i] ) - 1 ) for i in xrange( 1,len( self.dict_data[ time ] ) ) ] for time in self.times ]
        gapslist   = [ [ gaplist[i][1] ] + gapslist[i] for i in xrange( len(gaplist) ) ]
        gapsums    = [ reduce( lambda a,b:a + b, gaps ) for gaps in gapslist ] 
        j = 0
        for i in range( len( gapsums ) ):
            if gapsums[ i - j ] > len( gapslist[0] ) * self.Range:
               del gapsums[ i - j ]
               del self.times[ i - j ]
               j += 1
        self.times.insert( 0,self.endtime )
        gapsums.insert( 0,0 )
        self.gapdict = dict( zip( self.times,gapsums ) )
        return self.times

    def analysis2( self,stepInterval ):
        groupslist  = []
        group       = [ self.times[0] ]
        for i in range( len( self.times ) - 1 ):
            if ( self.times[ i ] - self.times[ i + 1 ] ) < stepInterval * 2:
                group.append( self.times[ i + 1 ] )

            else:
                groupslist.append( group )
                group = []
                group.append( self.times[ i + 1 ] )
        
        groupslist.append( group )
        del groupslist[ 0 ]
        mingap_times  = []
        
        for group in groupslist:
            mingap = self.gapdict[ group[0] ]
            for time in group:
                if self.gapdict[ time ] < mingap:
                    mingap       = self.gapdict[ time ]
                    mingap_time = time
            mingap_times.append( mingap_time )

        return mingap_times


                
                    

Main = Main()
Main.loadModel()
Main.createLoggers()
Main.getStepInterval()
Analysis = Analysis()

for i in range( Main.re ):
    Main.run()
    Data = Main.join()
    Analysis.dict_data = Data[0]
    Analysis.times = Data[1]
    Analysis.Set()
    Analysis.analysis1()
    print Analysis.analysis2( Main.stepInterval )
    

       


