loadModel('kuzumoto_et_al_2007_2.5Hz.Anoxya_394sec.eml')

step=10
t=394000
while 1:
	run(step)
	t += step
	saveModel('kuzumoto_et_al_2007_2.5Hz.Anoxya_' + str(t/1000.0) + 'sec.eml')
	if ( t == 394990 ):
		break
