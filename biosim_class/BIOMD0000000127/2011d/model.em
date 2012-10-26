Stepper FixedODE1Stepper(ODE)
{
#no property
}

Stepper DiscreteTimeStepper(DT)
{
#no property
}

System System(/)
{
    StepperID ODE;
Variable Variable(SIZE)
{
Value 1.0;
}
Variable Variable(I)
{
Value 0.0;
}
Variable Variable(t)
{
Value 0.0;
}
Process ExpressionFluxProcess(clock)
{
VariableReferenceList
[t :.:t 1];

Expression"1.0";
}
Process ExpressionAssignmentProcess(I)
{
StepperID DT;
VariableReferenceList
[t :.:t 0]
[I :.:I 1];
Expression "gt(t.Value,10)*10";
}
}

#セル内の情報
System System(/CELL)
{
StepperID ODE;

Variable Variable(SIZE)
{
Value 1.0;
}
Variable Variable(a)
{
Value 0.1;
}
Variable Variable(b)
{
Value 0.26;
}
Variable Variable(c)
{
Value -60.0;
}
Variable Variable(d)
{
Value -1.0;
}
Variable Variable(Vthresh)
{
Value 30.0;
}
Variable Variable(v)
{
Value -70.0;
}
Variable Variable(u)
{
Value -14.0;
}


Process ExpressionAssignmentProcess(u)
{
StepperID DT;
VariableReferenceList
[Vthresh :.:Vthresh 0]
[d :.:d 0]
[v :.:v 0]
[u :.:u 1];
Expression "geq(v.Value,Vthresh.Value)*(u.Value + d.Value)+lt(v.Value,Vthresh.Value)*u.Value";
}

Process ExpressionAssignmentProcess(v)
{
StepperID DT;
VariableReferenceList
[Vthresh :.:Vthresh 0]
[c :.:c 0]
[v :.:v 1];
Expression "geq(v.Value, Vthresh.Value)*c.Value+lt(v.Value,Vthresh.Value)*v.Value";
}

Process ExpressionFluxProcess(dvdt)
{
     VariableReferenceList
     [v :.:v 1]
     [u :.:u 0]
     [I :/:I 0];
      Expression "0.04*pow(v.Value,2)+5*v.Value+140-u.Value+I.Value";
}

Process ExpressionFluxProcess(dudt)
{
     VariableReferenceList
    [u :.:u 1]
    [a :.:a 0]
    [b :.:b 0]
    [v :.:v 0];
   
    Expression "a.Value*(b.Value*v.Value-u.Value)";

}
}