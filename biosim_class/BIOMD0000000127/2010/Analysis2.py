class Analysis:
    def __init__( self ):
        self.dict_data = None
        self.times     = None
        self.endtime   = None
        self.Range     = 1.01
        self.result    = None
        self.judge     = 'failure'
   
    def Set( self ):
        self.times.reverse()
        self.endtime  = self.times[ 0 ]                      
